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

        // Opportunities
        $totalOpportunities = Opportunity::count();
        $opportunityPotentialIncome = Opportunity::whereIn('status', ['negotiation', 'proposal', 'qualification'])->sum('amount');
        $opportunityTotalIncome = Opportunity::whereIn('status', ['closed_won'])->sum('amount');
        $opportunityPotentialTotalIncome = $opportunityPotentialIncome + $opportunityTotalIncome;

        // <editor-fold desc="TOTAL ACCUMULATED INCOME PER MONTH">
        $monthlyIncome = [];
        $totalIncome = 0;

        // Requête
        $incomeDataMonth = Opportunity::where('status', 'closed_won')
            ->where('updated_at', '>=', now()->subYear())
            ->orderBy('updated_at', 'asc')
            ->get();

        // Boucle sur chaque opportunités
        foreach ($incomeDataMonth as $month) {
            $monthFormat = $month->updated_at->format('M Y');

            // If month !exists in array, initialize
            if (! isset($monthlyIncome[$monthFormat])) {
                $monthlyIncome[$monthFormat] = [
                    'month' => $monthFormat,
                    'amount' => 0,
                    'total' => 0,
                ];
            }

            // Montant du mois en cours
            $monthlyIncome[$monthFormat]['amount'] += (float) $month->amount;

        }
        // Cumulation du montant
        foreach ($monthlyIncome as $data) {
            $totalIncome += $data['amount'];
            $data['total'] += $totalIncome;
        }
        // </editor-fold>

        // <editor-fold desc="INCOME PER WEEK OVER 6 MONTHS">
        $weeklyIncome = [];

        $incomeDataWeek = Opportunity::where('status', 'closed_won')
            ->where('updated_at', '>=', now()->subMonths(6))
            ->get();

        foreach ($incomeDataWeek as $data) {
            $weekFormat = 'Sem. '.$data->updated_at->format('W');

            if (! isset($weeklyReport[$weekFormat])) {
                $weeklyReport[$weekFormat] = [
                    'label' => $weekFormat,
                    'income' => 0,
                ];
            }

            $weeklyIncome[$weekFormat]['income'] += (float) $data->amount;
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
        $incomePerDayPerWeek = $incomeDataWeek->map(fn ($item) => [
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
        $incomePerDayPerMonth = $incomeDataMonth->map(fn ($item) => [
            // Format day-Month
            'day' => date('d-M', strtotime($item->date)),
            'amount' => (float) $item->total,
        ]);
        // </editor-fold>

        // Dernières opportunités
        $latestOpportunities = Opportunity::with('orders')->latest()->limit(10)->get();

        // Dernières opportunités en dépend de status et/ou type
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
            ->with(['orders' => function ($query) {
                $query->latest();
            }])->latest()->limit(10)->get();

        // Dernières activités
        $latestActivities = Activity::latest()->limit(10)->get();

        // Envoi des données vers dashboard
        return Inertia::render('chart-dashboard', [
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
        ]);
    }
}
