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
        Role::updateOrCreate(['rolename' => 'admin']);
        Role::updateOrCreate(['rolename' => 'manager']);
        Role::updateOrCreate(['rolename' => 'sales_rep']);
    }
}
