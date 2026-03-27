<?php

use App\Http\Controllers\ClientController;
use App\Http\Controllers\DashboardController;
use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Features;

Route::inertia('/', 'welcome', [
    'canRegister' => Features::enabled(Features::registration()),
])->name('home');

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('chart-dashboard', DashboardController::class)->name('chart.dashboard');
});

Route::middleware(['auth'])->group(function () {
    Route::resource('clients', ClientController::class)->except(['create', 'edit']);
});

require __DIR__.'/settings.php';
