<?php

namespace Database\Seeders;

use App\Models\Role;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Role::updateOrCreate(['name' => 'admin'], ['description' => 'Administrator with full access']);
        Role::updateOrCreate(['name' => 'manager'], ['description' => 'Manager with team access']);
        Role::updateOrCreate(['name' => 'sales'], ['description' => 'Sales representative with personal access']);
    }
}
