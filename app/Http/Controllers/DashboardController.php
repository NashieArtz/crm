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

        $baseClientQuery = Client::when(!$user->isAdmin(), function ($query) use ($user) {
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

        $totalOpportunities = Opportunity::count();

        $opportunityPotentialIncome = Opportunity::whereIn(
            'status',
            [
                'negotiation',
                'proposal',
                'qualification',
            ]
        )->sum('amount');

        $opportunityTotalIncome = Opportunity::whereIn('status', ['closed_won'])->sum('amount');
        $opportunityPotentialTotalIncome = $opportunityPotentialIncome + $opportunityTotalIncome;

        // <editor-fold desc="TOTAL ACCUMULATED INCOME PER MONTH">
        $monthlyIncome = [];
        $totalIncome = 0;

        for ($i = 11; $i >= 0; $i--) {
            $monthDate = now()->subMonths($i);
            $monthLabel = $monthDate->format('M Y');

            $monthlyIncome[$monthLabel] = [
                'month' => $monthLabel,
                'amount' => 0,
                'total' => 0,
            ];
        }

        $incomeDataMonth = Opportunity::where('status', 'closed_won')
            ->where('updated_at', '>=', now()->subYear())
            ->orderBy('updated_at', 'asc')
            ->get();

        foreach ($incomeDataMonth as $month) {
            $monthFormat = $month->updated_at->format('M Y');
            if (isset($monthlyIncome[$monthFormat])) {
                $monthlyIncome[$monthFormat]['amount'] += (float) $month->amount;
            }
        }

        foreach ($monthlyIncome as &$data) {
            $totalIncome += $data['amount'];
            $data['total'] = $totalIncome;
        }
        unset($data);
        // </editor-fold>

        // <editor-fold desc="INCOME PER WEEK OVER 6 MONTHS">
        $weeklyIncome = [];

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
                DB::raw('DATE(updated_at) as date'),
                DB::raw('SUM(amount) as total'),
            ])
            ->groupBy('date')
            ->orderBy('date', 'asc')
            ->get();

        $incomePerDayPerMonth = $incomeDataMonth->map(fn($item) => [
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

        $latestActivities = Activity::with('clients:id_client,company_name')
            ->latest()
            ->limit(10)
            ->get();

        //<editor-fold desc="Piechart (nom, value) des opportunities par types">
        $baseWonQuery = (clone $baseOppQuery)->where('status', 'closed_won');
        $oppBySegments = (clone $baseWonQuery)
            ->select([
                'type',
                DB::raw('COUNT(*) as count'),
                DB::raw('SUM(amount) as total_amount'),
            ])
            ->groupBy('type')
            ->get()
            ->map(fn($item) => [
                'name' => ucfirst(str_replace('_', ' ', $item->type)),
                'value' => (float) $item->total_amount,
                'total' => (float) $item->total_amount,
            ]);
        //</editor-fold>

        //<editor-fold desc="Top 5 clients graph by filter">
        $topAccounts = (clone $baseWonQuery)
            ->select([
                'client_id',
                DB::raw('SUM(amount) as total_revenue'),
            ])
            ->with('client:id_client,company_name')
            ->groupBy('client_id')
            ->orderByDesc('total_revenue')
            ->limit(5)
            ->get()
            ->map(fn($item) => [
                'company' => $item->client->company_name ?? 'Deleted client',
                'revenue' => (float) $item->total_revenue,
            ]);
        //</editor-fold>

        $conversionRate = $totalClient > 0
            ? round(((clone $baseOppQuery)->where('status', 'closed_won')->count() / $totalClient) * 100, 1)
            : 0;

        $stats = [
            'total_clients' => $totalClient,
            'active_opportunities' => (clone $baseOppQuery)->whereNotIn('status', ['closed_won', 'closed_lost'])->count(),
            'total_revenue' => $opportunityTotalIncome,
            'conversion_rate' => $conversionRate,
        ];

        return Inertia::render('dashboard', [
            'stats' => $stats,
            'salesData' => array_values($monthlyIncome),
            'opportunityStats' => $oppBySegments,
            'recentActivities' => $latestActivities,

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
            'latestActivitiesData' => $latestActivities,
            'oppBySegments' => $oppBySegments,
            'topAccounts' => $topAccounts,
        ]);
    }
}
