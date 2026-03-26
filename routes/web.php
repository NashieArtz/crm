<?php

use App\Http\Controllers\RessourceController;
use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Features;

Route::inertia('/', 'welcome', [
    'canRegister' => Features::enabled(Features::registration()),
])->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::inertia('dashboard', 'dashboard')->name('dashboard');
});

// Créer un client
Route::get('/client/create', [RessourceController::class, 'index']) ->name('client.index');
Route::post('client/create', [RessourceController::class, 'create']) ->name('client.create');

require __DIR__.'/settings.php';

