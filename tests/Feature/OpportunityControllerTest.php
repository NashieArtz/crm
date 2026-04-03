<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\Client;
use App\Models\Opportunity;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class OpportunityControllerTest extends TestCase
{
    use RefreshDatabase;
    protected $seed = true;

    public function test_un_utilisateur_peut_creer_une_opportunite()
    {
        $user = User::factory()->create();

        $client = Client::create([
            'company_name' => 'Client Pour Opportunite',
            'email' => 'opp@client.com',
        ]);

        $response = $this->actingAs($user)->post('/opportunities', [
            'source' => 'Formulaire Web',
            'details' => 'Projet de refonte CRM',
            'status' => 'qualification',
            'type' => 'new_business',
            'amount' => 12500.50,
            'closed_date' => '2026-12-31',
            'client_id' => $client->id_client
        ]);

        $response->assertStatus(302);

        // CORRECTION : On s'assure que Laravel renvoie bien un message de succès
        $response->assertSessionHas('success');

        $this->assertDatabaseHas('opportunities', [
            'amount' => 12500.50,
            'status' => 'qualification',
            'client_id' => $client->id_client,
        ]);
    }

    public function test_la_validation_bloque_un_statut_invalide()
    {
        $user = User::factory()->create();

        $client = Client::create([
            'company_name' => 'Client Test 2',
            'email' => 'test2@client.com',
        ]);

        $response = $this->actingAs($user)->post('/opportunities', [
            'details' => 'Opportunité test invalide', // Ajout d'un détail unique pour la retrouver
            'status' => 'statut_invente',
            'type' => 'new_business',
            'closed_date' => '2026-12-31',
            'client_id' => $client->id_client,
        ]);

        $response->assertSessionHasErrors('status');

        // CORRECTION : On vérifie que CETTE opportunité précise n'est pas dans la BDD
        $this->assertDatabaseMissing('opportunities', [
            'details' => 'Opportunité test invalide'
        ]);
    }

    public function test_un_utilisateur_peut_modifier_une_opportunite()
    {
        $user = User::factory()->create();

        $client = Client::create([
            'company_name' => 'Client Test 3',
            'email' => 'test3@client.com',
        ]);

        $opportunity = Opportunity::create([
            'client_id' => $client->id_client,
            'status' => 'proposal',
            'type' => 'upsell',
            'amount' => 5000,
            'closed_date' => '2026-10-15',
        ]);

        $response = $this->actingAs($user)->put("/opportunities/{$opportunity->id_opportunity}", [
            'status' => 'closed_won',
            'amount' => 7500,
            'type' => 'upsell',
            'closed_date' => '2026-10-15',
            'client_id' => $client->id_client,
        ]);

        // Si tu as bien corrigé le Contrôleur, le Request->validated() marchera et on aura un succès
        $response->assertSessionHas('success');

        $this->assertDatabaseHas('opportunities', [
            'id_opportunity' => $opportunity->id_opportunity,
            'status' => 'closed_won',
            'amount' => 7500,
        ]);
    }
}
