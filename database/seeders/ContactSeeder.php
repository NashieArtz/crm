<?php

namespace Database\Seeders;

use App\Models\Client;
use App\Models\Contact;
use Illuminate\Database\Seeder;

class ContactSeeder extends Seeder
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
            $numberOfContacts = rand(1, 3);
            for ($i = 0; $i < $numberOfContacts; $i++) {
                $email = fake()->unique()->safeEmail();

                Contact::updateOrCreate(
                    ['email' => $email],
                    [
                        'first_name' => fake()->firstName(),
                        'last_name' => fake()->lastName(),
                        'phone' => fake()->phoneNumber(),
                        'type' => fake()->randomElement(['lead', 'prospect', 'customer', 'partner']),
                        'description' => fake()->paragraph(),
                        'client_id' => $client->id_client,
                    ]
                );
            }
        }
    }
}
