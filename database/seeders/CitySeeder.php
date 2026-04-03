<?php

namespace Database\Seeders;

use App\Models\City;
use App\Models\Country;
use Illuminate\Database\Seeder;

class CitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {

        $franceId = Country::where('name', 'France')->value('id_country');
        $belgiqueId = Country::where('name', 'Belgique')->value('id_country');
        $suisseId = Country::where('name', 'Suisse')->value('id_country');
        $allemagneId = Country::where('name', 'Allemagne')->value('id_country');
        $luxembourgId = Country::where('name', 'Luxembourg')->value('id_country');
        $canadaId = Country::where('name', 'Canada')->value('id_country');
        $espagneId = Country::where('name', 'Espagne')->value('id_country');
        $italieId = Country::where('name', 'Italie')->value('id_country');
        $royaumeUniId = Country::where('name', 'Royaume-Uni')->value('id_country');
        $etatsUnisId = Country::where('name', 'États-Unis')->value('id_country');

        $citiesFrance = [
            ['name' => 'Rouen'],
            ['name' => 'Paris'],
            ['name' => 'Lyon'],
            ['name' => 'Marseille'],
            ['name' => 'Lille'],
            ['name' => 'Bordeaux'],
            ['name' => 'Nantes'],
            ['name' => 'Strasbourg'],
            ['name' => 'Toulouse'],
            ['name' => 'Montpellier'],
        ];

        $citiesBelgique = [
            ['name' => 'Bruxelles'],
            ['name' => 'Anvers'],
            ['name' => 'Gand'],
            ['name' => 'Charleroi'],
            ['name' => 'Liège'],
            ['name' => 'Bruges'],
            ['name' => 'Namur'],
            ['name' => 'Louvain'],
            ['name' => 'Mons'],
            ['name' => 'Malines'],
            ['name' => 'Alost'],
            ['name' => 'La Louvière'],
            ['name' => 'Hasselt'],
            ['name' => 'Courtrai'],
            ['name' => 'Tournai'],
            ['name' => 'Seraing'],
            ['name' => 'Verviers'],
            ['name' => 'Mouscron'],
            ['name' => 'Braine-l\'Alleud'],
            ['name' => 'Wavre'],
        ];

        $citiesSuisse = [
            ['name' => 'Genève'],
            ['name' => 'Zurich'],
            ['name' => 'Lausanne'],
            ['name' => 'Berne'],
            ['name' => 'Bâle'],
        ];

        $citiesAllemagne = [
            ['name' => 'Berlin'],
            ['name' => 'Munich'],
            ['name' => 'Hambourg'],
            ['name' => 'Francfort'],
            ['name' => 'Cologne'],
        ];

        $citiesLuxembourg = [
            ['name' => 'Luxembourg-Ville'],
            ['name' => 'Esch-sur-Alzette'],
            ['name' => 'Differdange'],
            ['name' => 'Dudelange'],
        ];

        $citiesCanada = [
            ['name' => 'Montréal'],
            ['name' => 'Québec'],
            ['name' => 'Toronto'],
            ['name' => 'Ottawa'],
            ['name' => 'Vancouver'],
        ];

        $citiesEspagne = [
            ['name' => 'Madrid'],
            ['name' => 'Barcelone'],
            ['name' => 'Valence'],
            ['name' => 'Séville'],
            ['name' => 'Bilbao'],
        ];

        $citiesItalie = [
            ['name' => 'Rome'],
            ['name' => 'Milan'],
            ['name' => 'Naples'],
            ['name' => 'Turin'],
            ['name' => 'Florence'],
        ];

        $citiesRoyaumeUni = [
            ['name' => 'Londres'],
            ['name' => 'Manchester'],
            ['name' => 'Birmingham'],
            ['name' => 'Édimbourg'],
            ['name' => 'Glasgow'],
        ];

        $citiesEtatsUnis = [
            ['name' => 'New York'],
            ['name' => 'Los Angeles'],
            ['name' => 'Chicago'],
            ['name' => 'Miami'],
            ['name' => 'San Francisco'],
        ];

        foreach ($citiesFrance as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $franceId]);
        }
        foreach ($citiesBelgique as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $belgiqueId]);
        }

        foreach ($citiesSuisse as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $suisseId]);
        }

        foreach ($citiesAllemagne as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $allemagneId]);
        }

        foreach ($citiesLuxembourg as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $luxembourgId]);
        }

        foreach ($citiesCanada as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $canadaId]);
        }

        foreach ($citiesEspagne as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $espagneId]);
        }

        foreach ($citiesItalie as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $italieId]);
        }

        foreach ($citiesRoyaumeUni as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $royaumeUniId]);
        }

        foreach ($citiesEtatsUnis as $city) {
            City::updateOrCreate(['name' => $city['name'], 'country_id' => $etatsUnisId]);
        }
    }
}
