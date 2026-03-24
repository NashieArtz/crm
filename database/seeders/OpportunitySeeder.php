<?php

namespace Database\Seeders;

use App\Models\Client;
use App\Models\Opportunity;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class OpportunitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $clients = Client::all();

        if ($clients->isEmpty()) {
            $this->command->warn('No clients created!');
            return;
        }

        foreach ($clients as $client) {
            foreach (range(1, 2) as $index) {
                Opportunity::create([
                    'source' => fake()->randomElement(['LinkedIn', 'Website', 'Referral', 'Cold Call', 'Trade Show']),
                    'details' => fake()->paragraph(),
                    'status' => fake()->randomElement([
                        'qualification',
                        'proposal',
                        'negotiation',
                        'closed_won',
                        'closed_lost',
                    ]),
                    'type' => fake()->randomElement([
                        'new_business',
                        'upsell',
                        'renewal',
                    ]),
                    'amount' => fake()->randomFloat(2, 500, 50000),
                    'closed_date' => fake()->dateTimeBetween('now', '+6 months'),
                    'client_id' => $client->id_client,
                    ]
                );
            }
        }
    }
}
