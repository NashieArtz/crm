<?php

namespace App\Models;

use Database\Factories\ClientFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Client extends Model
{
    /** @use HasFactory<ClientFactory> */
    use HasFactory;

    /**
     * Changement du nom de la colonne id en 'id_client' au lieu de juste 'id'
     */
    protected $primaryKey = 'id_client';

    // Remplissage des colonnes
    protected $fillable = [
        'company_name',
        'email',
        'phone',
        'website',
        'income',
    ];

    // RELATIONS

    /**
     * Client peut avoir plusieurs address
     * Mention de 'client_id' qui est la fk dans migrations/addresses
     * Mention de 'id_client' qui est la pk dans migrations/clients et Models/Client
     * Comparaison des deux pour les reliers
     */
    public function addresses(): HasMany
    {
        return $this->hasMany(Address::class, 'client_id', 'id_client');
    }

    public function contacts(): HasMany
    {
        return $this->hasMany(Contact::class, 'client_id', 'id_client');
    }

    public function opportunities(): HasMany
    {
        return $this->hasMany(Opportunity::class, 'client_id', 'id_client');
    }

    public function activities(): BelongsToMany
    {
        return $this->belongsToMany(Activity::class, 'activity_client', 'client_id', 'activity_id');
    }

    // Many to Many
    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'client_user', 'client_id', 'user_id')
            ->withPivot('is_primary')
            ->withTimestamps();
    }
}
