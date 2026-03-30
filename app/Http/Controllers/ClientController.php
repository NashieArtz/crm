<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Http\Requests\ClientRequest;
use Illuminate\Http\RedirectResponse;
use Inertia\Inertia;
use Inertia\Response;

class ClientController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // Get les clients les plus récents
        $clients = Client::latest()->get();

        return Inertia::render('Client/Index', [
<<<<<<< HEAD
            'clients' => $clients
        ]);
    }

<<<<<<< HEAD
<<<<<<< HEAD
=======
    //<editor-fold desc="Description">
    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }
    //</editor-fold>
>>>>>>> bd64d29 (feat: CRUD client)
=======
>>>>>>> 2be1091 (feat: CRUD client)
=======
            'clients' => $clients,
        ]);
    }

>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61

    /**
     * Store a newly created resource in storage.
     */
    public function store(ClientRequest $request): RedirectResponse
    {
        Client::create($request->validated());

        // Message flash
        // Check avec inertia flash
        return redirect()->route('clients.index')->with('success', 'Client created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Client $client): Response
    {
        $client->load(['contacts', 'opportunities', 'activities']);

        return Inertia::render('Client/Show', [
<<<<<<< HEAD
            'client' => $client
=======
            'client' => $client,
>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61
        ]);
    }

    /**
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {

    }

    /**
>>>>>>> bd64d29 (feat: CRUD client)
=======
>>>>>>> 2be1091 (feat: CRUD client)
=======
>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61
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
}
