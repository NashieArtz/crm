<?php

namespace Database\Seeders;

use App\Models\Country;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class CountrySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $countries = [
            ['name' => 'France'],
            ['name' => 'Belgique'],
            ['name' => 'Suisse'],
            ['name' => 'Luxembourg'],
            ['name' => 'Canada'],
            ['name' => 'Allemagne'],
            ['name' => 'Espagne'],
            ['name' => 'Italie'],
            ['name' => 'Royaume-Uni'],
            ['name' => 'États-Unis'],
        ];

        foreach ($countries as $country) {
            Country::updateOrCreate($country);
        }
    }
}
