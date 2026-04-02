<?php

namespace App\Http\Controllers;

use App\Http\Requests\ClientRequest;
use App\Models\Client;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Inertia\Inertia;
use Inertia\Response;

class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // L'user connecté
        $user = auth()->user();

        // analyse requête HTTP, GET (?search=)
        $search = $request->input('search');
        $status = $request->input('status');
        $sort = $request->input('sort', 'desc');

        // Get les clients les plus récents
        $clients = Client::query()
            ->when(! $user->isAdmin(), function ($query) use ($user) {
                // Si pas admin, on ne voit que les clients où on est présent si on est dans table pivot
                $query->whereHas('users', function ($q) use ($user) {
                    $q->where('client_user.user_id', $user->id_user);
                });
            })
            // Recherche sécurisé
            ->when($search, function ($query, $search) {
                // $q add parenthèses invisibles en SQL
                $query->where(function ($q) use ($search) {
                    $q->where('company_name', 'ilike', "%{$search}%")
                        ->orWhere('website', 'ilike', "%{$search}%");
                });
            })
            // Filtre par status
            ->when($status, function ($query, $status) {
                $query->whereHas('opportunities', function ($q) use ($status) {
                    $q->where('status', $status);
                });
            })
            // éviter requêtes N+1 pour la vue
            ->with(['contacts', 'opportunities'])
            // Tri
            ->when($sort === 'asc', function ($query) {
                $query->orderBy('company_name', 'asc');
            }, function ($query) {
                $query->latest();
            })
            ->get();

        // dd($clients->toArray());

        return Inertia::render('Client/Index', [
            'clients' => $clients,
            // Extrait only les données de (?search=)
            'filters' => $request->only(['search', 'status', 'sort']),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(ClientRequest $request): RedirectResponse
    {
        $validated = $request->validated();

        // Transaction pour save client et contact
        DB::transaction(function () use ($validated) {
            // Extraction manuelle, éviter insérer tableau contacts
            $client = Client::create([
                'company_name' => $validated['company_name'],
                'email' => $validated['email'],
                'phone' => $validated['phone'] ?? null,
                'website' => $validated['website'] ?? null,
                'income' => $validated['income'] ?? null,
            ]);

            // Lier l'utilisateur connecté comme sales_rep principal du client
            $client->users()->attach(auth()->id(), ['is_primary' => true]);

            // Créer contacts si y'a
            if (!empty($validated['contacts'])) {
                foreach ($validated['contacts'] as $contactData) {
                    if (!empty($contactData['first_name']) && !empty($contactData['last_name'])) {
                        // Utilise la relation HasMany
                        $client->contacts()->create($contactData);
                    }
                }
            }
        });

        // Message flash
        // Check avec inertia flash
        return redirect()->route('clients.index')->with('success', 'Client created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Client $client): Response
    {
        $client->load(['contacts', 'opportunities', 'users',
            'activities' => function ($query) {
                $query->latest('date_activity');
            },
        ]);

        return Inertia::render('Client/Show', [
            'client' => $client,
        ]);
    }

    /**
<<<<<<< HEAD
     * Show the form for editing the specified resource.
     */
    public function edit(string $id) {}

    /**
=======
>>>>>>> cc887e61f740d417c581e075a25a3e10074639b7
     * Update the specified resource in storage.
     */
    public function update(ClientRequest $request, Client $client): RedirectResponse
    {
        // Vérifier la policy avant d'update
        Gate::authorize('update', $client);

        $clientData = collect($request->validated())->except('contacts')->toArray();
        $client->update($clientData);

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
