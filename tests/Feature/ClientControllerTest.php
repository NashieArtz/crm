<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ClientControllerTest extends TestCase
{
    use RefreshDatabase;

    protected $seed = true;

    public function test_un_utilisateur_peut_creer_un_client()
    {
        $user = User::factory()->create();

        // On envoie les données qui correspondent à ton fillable
        $response = $this->actingAs($user)->post('/clients', [
            'company_name' => 'Biscuit Studio',
            'email' => 'hello@biscuit.com',
            'phone' => '0612345678',
            'website' => 'https://biscuit.com',
            'income' => 50000
        ]);

        $response->assertRedirect('/clients');
        $response->assertSessionHas('success');

        $this->assertDatabaseHas('clients', [
            'company_name' => 'Biscuit Studio',
            'email' => 'hello@biscuit.com',
            'website' => 'https://biscuit.com',
        ]);
    }

    public function test_la_validation_bloque_les_emails_invalides()
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->post('/clients', [
            'company_name' => 'Biscuit Studio',
            'email' => 'mauvais-email',
        ]);

        $response->assertSessionHasErrors('email');

        $this->assertDatabaseMissing('clients', [
            'company_name' => 'Biscuit Studio'
        ]);
    }
}
