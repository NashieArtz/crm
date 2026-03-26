<?php

namespace App\Http\Controllers;

use App\Models\Activity;
use App\Models\Client;
use App\Models\Opportunity;
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


        $incomePerWeek = Opportunity::whereIn('status', ['closed_won'])
            ->where('updated_at', '>=', now()->subWeek())
            ->sum('amount');
        
        $incomePerMonth = Opportunity::whereIn('status', ['closed_won'])
            ->where('updated_at', '>=', now()->subMonth())
            ->sum('amount');

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
        return Inertia::render('dashboard', [
            'totalClient' => $totalClient,
            'totalOpportunities' => $totalOpportunities,

            'incomePerWeek' => $incomePerWeek,
            'incomePerMonth' => $incomePerMonth,

            'opportunityPotentialIncome' => $opportunityPotentialIncome,
            'opportunityTotalIncome' => $opportunityTotalIncome,
            'opportunityPotentialTotalIncome' => $opportunityPotentialTotalIncome,

            'latestOpportunities' => $latestOpportunities,
            'latestOpportunitiesByOption' => $latestOpportunitiesByOption,
            'latestActivities' => $latestActivities,
        ]);
    }
}
