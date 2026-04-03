<?php

namespace App\Http\Controllers;

use App\Http\Requests\OpportunityRequest;
use App\Models\Opportunity;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class OpportunityController extends Controller
{
    public function index(): Response
    {
        $opportunities = Opportunity::with('client:id_client,company_name')->latest()->get();

        return Inertia::render('Opportunity/Index', [
            'opportunities' => $opportunities,
        ]);
    }

    public function store(OpportunityRequest $opportunityRequest): RedirectResponse
    {
        Opportunity::create($opportunityRequest->validated());

        return redirect()->back()->with('success', 'Opportunity created.');
    }

    public function update(OpportunityRequest $request, Opportunity $opportunity): RedirectResponse
    {
        $opportunity->update($request->validated());

        return redirect()->back()->with('success', 'Opportunity updated.');
    }

    public function destroy(Opportunity $opportunity): RedirectResponse
    {
        $opportunity->delete();

        return redirect()->back()->with('success', 'Opportunity deleted.');
    }
}
