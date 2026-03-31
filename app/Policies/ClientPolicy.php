<?php

namespace App\Policies;

use App\Models\Client;
use App\Models\User;

class ClientPolicy
{
    public function viewAny(User $user): bool
    {
        return true;
    }

    public function view(User $user, Client $client): bool
    {
        if ($user->isAdmin()) {
            return true;
        }

        return $client->users()->where('user_id', $user->id_user)->exists();
    }

    public function create(User $user): bool
    {
        return true;
    }

    public function update(User $user, Client $client): bool
    {
        if ($user->isAdmin()) {
            return true;
        }

        // Vérifie si l'utilisateur est le titulaire principal (is_primary = true)
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
