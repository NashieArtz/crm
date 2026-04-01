<?php

namespace App\Http\Controllers;

use App\Http\Requests\ActivityRequest;
use App\Http\Requests\StoreActivityRequest;
use App\Http\Requests\UpdateActivityRequest;
use App\Models\Activity;
use Illuminate\Http\RedirectResponse;
use Inertia\Inertia;
use Inertia\Response;

class ActivityController extends Controller
{
    public function index(): Response
    {
        $activities = Activity::with('client:id_client,company_name')->latest('activity_date')->get();

        return Inertia::render('Activities/Index', [
            'activities' => $activities,
        ]);
    }

    public function store(StoreActivityRequest $request): RedirectResponse
    {
        $activity = Activity::create($request->validated());

        // Liaison clients envoyés dans tableau client_ids
        if ($request->has('client_ids')) {
            $activity->clients()->attach($request->client_ids);
        }

        return redirect()->back()->with('success', 'Activity created successfully.');
    }

    public function update(UpdateActivityRequest $request, Activity $activity): RedirectResponse
    {
        $activity->update($request->validated());

        // Suppresion anciens, ajout nouveaux clients
        if ($request->has('client_ids')) {
            $activity->clients()->sync($request->client_ids);
        }

        return redirect()->back()->with('success', 'Activity updated successfully.');
    }

    public function destroy(Activity $activity): RedirectResponse
    {
        $activity->delete();

        return redirect()->back()->with('success', 'Activity deleted successfully.');
    }
}
