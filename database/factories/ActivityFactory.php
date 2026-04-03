<?php

namespace Database\Factories;

use App\Models\activity;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<activity>
 */
class ActivityFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'type' => fake()->randomElement(['call', 'email', 'meeting', 'task', 'note']),
            'description' => fake()->text(200),
            'date_activity' => fake()->dateTimeThisYear(),
        ];
    }
}
