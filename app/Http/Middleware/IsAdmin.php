<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class IsAdmin
{
    public function handle(Request $request, Closure $next): Response
    {
        // On vérifie si l'utilisateur est connecté et s'il a role_id d'admin
        if (! auth()->check() || auth()->user()->role_id !== 1) {
            abort(403, 'Accès non autorisé.');
        }

        return $next($request);
    }
}
