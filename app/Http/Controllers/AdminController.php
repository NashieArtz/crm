<?php

namespace App\Http\Controllers;

use App\Models\Client;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class AdminController extends Controller
{
    public function transferOwnership(Request $request, Client $client): RedirectResponse
    {
        // Que admin/user_primary peut delete un client
        Gate::authorize('delete', $client);

        $request->validate(['user_id' => 'required|exists:users,id_user']);

        // On passe tous les anciens users en is_primary = false
        $client->users()->updateExistingPivot($client->users->pluck('id_user'), ['is_primary' => false]);

        // On met à jour le nouveau titulaire en true
        $client->users()->syncWithoutDetaching([$request->user_id => ['is_primary' => true]]);

        return redirect()->back()->with('success', 'Client transferred.');
    }
}
