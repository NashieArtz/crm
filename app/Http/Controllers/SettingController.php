<?php

namespace App\Http\Controllers;

use App\Models\Setting;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class SettingController extends Controller
{
    public function index(): Response
    {
        // Transforme toutes les lignes de la BDD en array key => value
        $settings = Setting::pluck('value', 'key')->toArray();

        return Inertia::render('Admin/Settings/Index', [
            'settings' => $settings,
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $data = $request->except(['_token']);

        // Boucle sur chaque champ envoyé et le met à jour ou le créer
        foreach ($data as $key => $value) {
            Setting::updateOrCreate(
                ['key' => $key],
                ['value' => $value]
            );
        }

        return back()->with('success', 'Paramètres sauvegardés avec succès.');
    }
}
