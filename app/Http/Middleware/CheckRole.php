<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckRole
{
    public function handle(Request $request, Closure $next, string $role): Response
    {
        if (! auth()->check() || ! auth()->user()->hasRole($role)) {
            abort(403, 'Unauthorized action.');
        }

        // Permet de passer à la prochaine requête
        return $next($request);
    }
}
