<?php

namespace Database\Seeders;

use App\Models\Activity;
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

        foreach ($activities as $activity) {
            Activity::updateOrCreate(
                ['type' => $activity['type']],
                ['description' => fake()->sentence(10),
                    'date_activity' => fake()->dateTimeBetween('-1 month', '+1 month'),
                ]
            );
        }
    }
}
