<?php

use App\Http\Controllers\AddressController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ActivityController;
use App\Http\Controllers\OpportunityController;
use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Features;

Route::inertia('/', 'welcome', [
    'canRegister' => Features::enabled(Features::registration()),
])->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('dashboard', DashboardController::class)->name('dashboard');
});

// CRUD
Route::middleware(['auth'])->group(function () {
    Route::resource('clients', ClientController::class)->except(['create', 'edit']);
    Route::resource('opportunities', OpportunityController::class)->except(['create', 'edit', 'show']);
    Route::resource('activities', ActivityController::class)->except(['create', 'edit', 'show']);
    Route::resource('contacts', ContactController::class)->except(['create', 'edit', 'show']);
    Route::resource('addresses', AddressController::class)->except(['create', 'edit', 'show']);
});

//

require __DIR__.'/settings.php';
