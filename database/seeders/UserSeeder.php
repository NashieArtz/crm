<?php

namespace Database\Seeders;

use App\Models\Role;
use App\Models\User;
use Hash;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $adminRole = Role::where('rolename', 'admin')->first();
        $salesRole = Role::where('rolename', 'sales_rep')->first();

        User::updateOrCreate(
            ['email' => 'admin@biscuit.fr'],
            [
                'username' => 'Admin Biscuit',
                'password' => Hash::make('password'),
                'role_id' => $adminRole->id_role,
            ]
        );



        if ($salesRole) {
            foreach (range(1, 5) as $index) {
                User::create([
                    'username' => fake()->name(),
                    'email' => fake()->unique()->safeEmail(),
                    'password' => Hash::make('password'),
                    'role_id' => $salesRole->id_role,
                ]);
            }
        }

    }
}
