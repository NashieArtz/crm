<?php

namespace Database\Seeders;

use App\Models\Activity;
use App\Models\Client;
use Illuminate\Database\Seeder;

class ActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $activities = [
            ['type' => 'call'],
            ['type' => 'email'],
            ['type' => 'meeting'],
            ['type' => 'task'],
            ['type' => 'note'],
        ];

        foreach ($activities as $activityIndex) {
            $activity = Activity::updateOrCreate(
                ['type' => $activityIndex['type']],
                ['description' => fake()->sentence(10),
                    'date_activity' => fake()->dateTimeBetween('-1 month', '+1 month'),
                ]
            );

            $randomClients = Client::inRandomOrder()
                ->take(rand(1, 3))
                ->pluck('id_client')
                ->toArray();
            $activity->clients()->syncWithoutDetaching($randomClients);
        }
    }
}
