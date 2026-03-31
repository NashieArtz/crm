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
        Activity::create($request->validated());

        return redirect()->back()->with('success', 'Activité créée.');
    }

    public function update(UpdateActivityRequest $request, Activity $activity): RedirectResponse
    {
        $activity->update($request->validated());

        return redirect()->back()->with('success', 'Activité mise à jour.');
    }

    public function destroy(Activity $activity): RedirectResponse
    {
        $activity->delete();

        return redirect()->back()->with('success', 'Activité supprimée.');
    }
}
