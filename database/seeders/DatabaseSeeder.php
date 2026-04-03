<?php

namespace Database\Seeders;

use App\Models\User;
use App\Models\Client;
use App\Models\Role;
use App\Models\Country;
use App\Models\City;
use App\Models\Contact;
use App\Models\Opportunity;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();
        $this->call([
            RoleSeeder::class,
            CountrySeeder::class,
        ]);

        $this->call([
            CitySeeder::class,
            UserSeeder::class,
        ]);

        $this->call([
            ClientSeeder::class,
        ]);

        $this->call([
            ActivitySeeder::class,
            ContactSeeder::class,
            OpportunitySeeder::class,
            AddressSeeder::class,
        ]);


    }
}
