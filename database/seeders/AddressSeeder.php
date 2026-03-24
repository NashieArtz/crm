<?php

namespace Database\Seeders;

use App\Models\Address;
use App\Models\City;
use App\Models\Client;
use Illuminate\Database\Seeder;

class AddressSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void {

        // Récupération des clients et villes
        $clients = Client::all();
        $cities = City::all();

        // Sécurité
        if ($clients->isEmpty() || $cities->isEmpty()) {
            $this->command->warn('No clients or cities found');
            return;
        }

        foreach ($clients as $client) {
            Address::updateOrCreate(
                ['client_id' => $client->id_client],
                [
                    'street' => fake()->streetAddress(),
                    'number' => fake()->numberBetween(1, 300),
                    'postal_code' => fake()->postcode(),
                    'complement' => fake()->buildingNumber(),
                    'city_id' => $cities->random()->id_city,
                ]
            );
        }
    }
}
