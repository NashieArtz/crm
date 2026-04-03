<?php

namespace Database\Seeders;

use App\Models\Client;
use App\Models\User;
use Illuminate\Database\Seeder;

class ClientSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Récupération de l'ID des sales_reps
        $userIds = User::pluck('id_user');

        // Sécu
        if ($userIds->isEmpty()) {
            $this->command->warn('Missing user');

            return;
        }

        foreach (range(1, 20) as $index) {
            $companyName = fake()->company();

            $client = Client::updateOrCreate(
                ['email' => fake()->unique()->companyEmail()],
                [
                    'company_name' => $companyName,
                    'phone' => fake()->phoneNumber(),
                    'website' => 'https://www.'.strtolower(str_replace(' ', '-', $companyName)).'.com',
                    'created_at' => fake()->dateTimeBetween('-6 months', 'now'),
                ]
            );

            $randomUserIds = User::inRandomOrder()
                ->take(rand(1, 2))
                ->pluck('id_user')
                ->toArray();

            $client->users()->syncWithoutDetaching($randomUserIds);

        }
    }
}
