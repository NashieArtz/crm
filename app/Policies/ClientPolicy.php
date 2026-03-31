<?php

namespace App\Policies;

use App\Models\Client;
use App\Models\User;

class ClientPolicy
{
    // Voir liste client
    // Filtrage dans ClientController so, true
    public function viewAny(User $user): bool
    {
        return true;
    }

    // Voir client précis
    public function view(User $user, Client $client): bool
    {
        if ($user->isAdmin()) {
            return true;
        }

        // Sales_rep voit si liée au client
        return $client->users()->where('user_id', $user->id_user)->exists();
    }

    // Créer nouveau client
    public function create(User $user): bool
    {
        return true;
    }

    // Mettre à jour nouveau client
    public function update(User $user, Client $client): bool
    {
        if ($user->isAdmin()) {
            return true;
        }

        // Vérifie si l'utilisateur est le titulaire principal (is_primary = true)
        // Remplaçant peut voir pas éditer
        return $client->users()
            ->where('user_id', $user->id_user)
            ->where('is_primary', true)
            ->exists();
    }

    public function delete(User $user, Client $client): bool
    {
        return $user->isAdmin();
    }

    public function restore(User $user, Client $client): bool
    {
        return $user->isAdmin();
    }

    public function forceDelete(User $user, Client $client): bool
    {
        return $user->isAdmin();
    }
}
