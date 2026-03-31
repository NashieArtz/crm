<?php

namespace App\Http\Controllers;

use App\Models\Activity;
use App\Models\Client;
use App\Models\Opportunity;
use DB;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;


class DashboardController extends Controller
{
    /**
     * Handle the incoming request.
     */
    public function __invoke(Request $request): Response
    {

        $user = auth()->user();

        $statusList = [
            'qualification',
            'proposal',
            'closed_won',
            'negotiation',
            'closed_lost',
        ];

        $typeList = [
            'renewal',
            'new_business',
            'upsell',
        ];
        $totalClient = Client::count();


        // Requêtes pour filtrer les données si l'user n'est pas admin
        $baseClientQuery = Client::when(!$user->isAdmin(), function ($query) use ($user) {
            // Cherche la relation pivot
            $query->whereHas('users', function ($q) use ($user) {
                $q->where('client_user.user_id', $user->id_user);
            });
        });

        $baseOppQuery = Opportunity::when(!$user->isAdmin(), function ($query) use ($user) {
            $query->whereHas('client.users', function ($q) use ($user) {
                $q->where('client_user.user_id', $user->id_user);
            });
        });

        $baseActivityQuery = Activity::when(!$user->isAdmin(), function ($query) use ($user) {
            $query->whereHas('clients.users', function ($q) use ($user) {
                $q->where('client_user.user_id', $user->id_user);
            });
        });

        // Opportunities
        $totalOpportunities = Opportunity::count();
        $opportunityPotentialIncome = Opportunity::whereIn('status', ['negotiation', 'proposal', 'qualification'])->sum('amount');
        $opportunityTotalIncome = Opportunity::whereIn('status', ['closed_won'])->sum('amount');
        $opportunityPotentialTotalIncome = $opportunityPotentialIncome + $opportunityTotalIncome;

        // <editor-fold desc="TOTAL ACCUMULATED INCOME PER MONTH">
        $monthlyIncome = [];
        $totalIncome = 0;

        // Génération des 12 mois en array
        for ($i = 11; $i >= 0; $i--) {
            $monthDate = now()->subMonths($i);
            $monthLabel = $monthDate->format('M Y');

            $monthlyIncome[$monthLabel] = [
                'month' => $monthLabel,
                'amount' => 0,
                'total' => 0,
            ];
        }

        // Requête
        $incomeDataMonth = Opportunity::where('status', 'closed_won')
            ->where('updated_at', '>=', now()->subYear())
            ->orderBy('updated_at', 'asc')
            ->get();

        // Boucle sur chaque opportunités
        foreach ($incomeDataMonth as $month) {
            $monthFormat = $month->updated_at->format('M Y');
            if (isset($monthlyIncome[$monthFormat])) {
                // Montant du mois en cours
                $monthlyIncome[$monthFormat]['amount'] += (float) $month->amount;
            }
        }
        // Cumulation du montant
        // Pointeur directe vers la mémoire
        foreach ($monthlyIncome as &$data) {
            $totalIncome += $data['amount'];
            $data['total'] = $totalIncome;
        }
        unset($data);
        // </editor-fold>

        // <editor-fold desc="INCOME PER WEEK OVER 6 MONTHS">
        $weeklyIncome = [];

        // Génération des semaines
        for ($i = 25; $i >= 0; $i--) {
            $weekDate = now()->subWeeks($i);
            $weekNum = $weekDate->format('W');
            $weeklyIncome[$weekNum] = [
                'label' => $weekNum,
                'income' => 0,
            ];
        }

        $incomeDataWeek = Opportunity::where('status', 'closed_won')
            ->where('updated_at', '>=', now()->subMonths(6))
            ->get();

        foreach ($incomeDataWeek as $data) {
            $weekFormat = $data->updated_at->format('W');
            if (isset($weeklyIncome[$weekFormat])) {
                $weeklyIncome[$weekFormat]['income'] += (float) $data->amount;
            }
        }
        // </editor-fold>

        // <editor-fold desc="INCOME PER DAY PER WEEK">
        $incomeDataWeek = Opportunity::where('status', ['closed_won'])
            ->where('updated_at', '>=', now()->subWeek())
            ->select([
                DB::raw('DATE(updated_at) as date'),
                DB::raw('SUM(amount) as total'),
            ])
            ->groupBy('date')
            ->orderBy('date', 'asc')
            ->get();
        $incomePerDayPerWeek = $incomeDataWeek->map(fn($item) => [
            'day' => date('d/m', strtotime($item->date)),
            'amount' => (float) $item->total,
        ]);
        // </editor-fold>

        // <editor-fold desc="INCOME PER DAY PER MONTH">
        $incomeDataMonth = Opportunity::where('status', 'closed_won')
            ->where('updated_at', '>=', now()->subDays(30))
            ->select([
                // DATE() keeps the date only
                DB::raw('DATE(updated_at) as date'),
                DB::raw('SUM(amount) as total'),
            ])
            // Regroupage des montants par date
            ->groupBy('date')
            ->orderBy('date', 'asc')
            ->get();
        $incomePerDayPerMonth = $incomeDataMonth->map(fn($item) => [
            // Format day-Month
            'day' => date('d-M', strtotime($item->date)),
            'amount' => (float) $item->total,
        ]);
        // </editor-fold>

        //<editor-fold desc="LAST OPPS">
        $latestOpportunities = Opportunity::with('client:id_client,company_name')
            ->latest()
            ->limit(10)
            ->get();
        //</editor-fold>

        //<editor-fold desc="LAST OPP DEPENDING ON STATUS/TYPE">
        $latestOpportunitiesByOption = Opportunity::query()
            ->when($request->input('status'), function ($query, $status) use ($statusList) {
                // Comparaison du tableau avec données valables et tableaux en requête
                $statuses = array_intersect((array) $status, $statusList);

                if (! empty($statuses)) {
                    $query->whereIn('status', $statuses);
                }
            })
            ->when($request->input('type'), function ($query, $type) use ($typeList) {
                $types = array_intersect((array) $type, $typeList);

                if (! empty($types)) {
                    $query->whereIn('type', $types);
                }
            })
            ->with('client:id_client,company_name')
            ->latest()
            ->limit(10)
            ->get();
        //</editor-fold>

        // Dernières activités
        $latestActivities = Activity::latest()->limit(10)->get();


        //<editor-fold desc="Piechart (nom, value) des opportunities par types">
        // clone pour ne pas modifier dans BDD/mémoire
        $baseWonQuery = (clone $baseOppQuery)->where('status', 'closed_won');
        $oppBySegments = (clone $baseWonQuery)
            ->select([
                'type',
                DB::raw('COUNT(*) as count'),
                DB::raw('SUM(amount) as total_amount')
            ])
            ->groupBy('type')
            ->get()
            // boucle sur chaque item de get()
            ->map(fn ($item) => [
                // ucfirst() -> upper case first
                'name' => ucfirst(str_replace('_', ' ', $item->type)),
                'value' => (float) $item->total_amount,
            ]);
        //</editor-fold>

        //<editor-fold desc="Top 5 clients graph by filter">
        $topAccounts = (clone $baseWonQuery)
            ->select([
                'client_id',
                DB::raw('SUM(amount) as total_revenue')
            ])
            ->with('client:id_client,company_name')
            ->groupBy('client_id')
            ->orderByDesc('total_revenue')
            ->limit(5)
            ->get()
            ->map(fn ($item) => [
                'company' => $item->client->company_name ?? 'Deleted client',
                'revenue' => (float) $item->total_revenue,
            ]);
        //</editor-fold>


        // Envoi des données vers dashboard
        return Inertia::render('dashboard', [
            'totalClient' => $totalClient,
            'totalOpportunities' => $totalOpportunities,

            'incomePerDayPerWeek' => $incomePerDayPerWeek,
            'incomePerDayPerMonth' => $incomePerDayPerMonth,

            'incomeData' => [
                'monthlyIncome' => array_values($monthlyIncome),
                'weeklyIncome' => array_values($weeklyIncome),
            ],

            'opportunityPotentialIncome' => $opportunityPotentialIncome,
            'opportunityTotalIncome' => $opportunityTotalIncome,
            'opportunityPotentialTotalIncome' => $opportunityPotentialTotalIncome,

            'latestOpportunities' => $latestOpportunities,
            'latestOpportunitiesByOption' => $latestOpportunitiesByOption,
            'latestActivities' => $latestActivities,

            'oppBySegments' => $oppBySegments,
            'topAccounts' => $topAccounts,
        ]);
    }
}
