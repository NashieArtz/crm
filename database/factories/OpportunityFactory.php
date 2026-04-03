<?php

namespace Database\Factories;

use App\Models\Client;
use App\Models\Opportunity;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Opportunity>
 */
class OpportunityFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'source' => fake()->randomElement(['Email', 'LinkedIn', 'Cold Call', 'Website']),
            'details' => fake()->paragraph(),
            'status' => fake()->randomElement(['qualification', 'proposal', 'negotiation', 'closed_won', 'closed_lost']),
            'type' => fake()->randomElement(['new_business', 'upsell', 'renewal']),
            'amount' => fake()->randomFloat(2, 500, 50000),
            'closed_date' => fake()->dateTimeBetween('now', '+6 months'),
            'client_id' => Client::factory(),
        ];
    }
}
