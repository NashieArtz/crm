<?php

use App\Http\Controllers\ActivityController;
use App\Http\Controllers\AddressController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\ContactController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\OpportunityController;
use App\Http\Controllers\SettingController;
use App\Http\Controllers\UserController;
use App\Http\Middleware\IsAdmin;
use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Features;

Route::inertia('/', 'welcome', [
    'canRegister' => Features::enabled(Features::registration()),
])->name('welcome');



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

// Role & Users Management
Route::middleware(['auth', IsAdmin::class])->group(function () {
    Route::get('/admin/users', [UserController::class, 'index'])->name('admin.users.index');
    Route::post('/admin/users', [UserController::class, 'store'])->name('admin.users.store');
    Route::put('/admin/users/{user}', [UserController::class, 'update'])->name('admin.users.update');
    Route::delete('/admin/users/{user}', [UserController::class, 'destroy'])->name('admin.users.destroy');
    Route::post('/clients/{client}/backup', [ClientController::class, 'addBackup'])->name('clients.backup.add');
    Route::delete('/clients/{client}/backup/{user}', [ClientController::class, 'removeBackup'])->name('clients.backup.remove');

    // Paramètres
    Route::get('/admin/settings', [SettingController::class, 'index'])->name('admin.settings.index');
    Route::post('/admin/settings', [SettingController::class, 'store'])->name('admin.settings.store');
});

require __DIR__.'/settings.php';
