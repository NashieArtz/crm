<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class RessourceController extends Controller
{

    public function index(Request $request): Response
    {
        return Inertia::render('client/create');
    }

    public function FormRequest(Request $request, array $clientData): void
    {


    }
}
