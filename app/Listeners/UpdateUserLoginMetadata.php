<?php

namespace App\Listeners;

use Carbon\Carbon;
use Illuminate\Auth\Events\Login;

class UpdateUserLoginMetadata
{
    public function handle(Login $event): void
    {
        // met a jour les infos de l'utilisateur
        $event->user->update([
            'last_login_at' => Carbon::now(),
            'last_login_ip' => request()->ip(),
        ]);
    }
}
