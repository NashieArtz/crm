<?php

use App\Http\Controllers\ClientController;
<<<<<<< HEAD
<<<<<<< HEAD
use App\Http\Controllers\DashboardController;
=======
>>>>>>> bd64d29 (feat: CRUD client)
=======
use App\Http\Controllers\DashboardController;
>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61
use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Features;

Route::inertia('/', 'welcome', [
    'canRegister' => Features::enabled(Features::registration()),
])->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', DashboardController::class)->name('dashboard');
});

<<<<<<< HEAD
<<<<<<< HEAD
=======
// Créer un client
// Middleware protect route from unlogged users
>>>>>>> bd64d29 (feat: CRUD client)
=======
>>>>>>> f2605f16a9741743c9e9c2cb6727c7b3d05c1b61
Route::middleware(['auth'])->group(function () {
    Route::resource('clients', ClientController::class)->except(['create', 'edit']);
});

require __DIR__.'/settings.php';
