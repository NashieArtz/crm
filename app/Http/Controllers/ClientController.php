<?php

namespace App\Http\Controllers;

use App\Http\Requests\ClientRequest;
use App\Models\Client;
use App\Models\User;
use Illuminate\Support\Facades\Gate;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // L'user connecté
        $user = auth()->user();

        // Get les clients les plus récents
        $clients = Client::query()
            ->when(!$user->isAdmin(), function ($query) use ($user) {
                // Si pas admin, on ne voit que les clients où on est présent si on est dans table pivot
                $query->whereHas('users', function ($q) use ($user) {
                    $q->where('user_id', $user->id_user);
                });
            })
            ->latest()
            ->get();

        return Inertia::render('Client/Index', [
            'clients' => $clients,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ClientRequest $request): RedirectResponse
    {
        $client = Client::create($request->validated());

        // Lier l'utilisateur connecté comme sales_rep principal du client
        $client->users()->attach(auth()->id(), ['is_primary' => true]);

        // Message flash
        // Check avec inertia flash
        return redirect()->route('clients.index')->with('success', 'Client created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Client $client): Response
    {
        $client->load(['contacts', 'opportunities',
            'activities' => function ($query) {
                $query->latest('date_activity');
            },
        ]);

        return Inertia::render('Client/Show', [
            'client' => $client,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(ClientRequest $request, Client $client): RedirectResponse
    {
        $client->update($request->validated());

        return redirect()->route('clients.index')->with('success', 'Client updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Client $client): RedirectResponse
    {
        $client->delete();

        return redirect()->route('clients.index')->with('success', 'Client deleted successfully.');
    }

    public function addBackup(Request $request, Client $client): RedirectResponse
    {
        // Seul l'admin ou le titulaire peut ajouter un remplaçant
        Gate::authorize('update', $client);

        $request->validate([
            'user_id' => 'required|exists:users,id_user',
        ]);

        // On attache le remplaçant avec is_primary à false
        $client->users()->attach($request->user_id, ['is_primary' => false]);

        return redirect()->back()->with('success', 'Backup user assigned successfully.');
    }

    public function removeBackup(Request $request, Client $client, User $user): RedirectResponse
    {
        // Seul le titulaire peut virer son backup
        Gate::authorize('update', $client);
        $client->users()->detach($user->id_user);
        return redirect()->back()->with('success', 'Backup removed.');
    }
}
