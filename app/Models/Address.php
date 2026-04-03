<?php

namespace App\Models;

use Database\Factories\AddressFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Address extends Model
{
    /** @use HasFactory<AddressFactory> */
    use HasFactory;

    protected $primaryKey = 'id_address';

    protected $fillable = [
        'street',
        'number',
        'postal_code',
        'complement',
        'client_id',
    ];

    // Une adresse appartient à plusieurs classes Client
    public function client(): BelongsTo
    {
        return $this->belongsTo(Client::class);
    }

    // Une adresse appartient à une seule ville
    public function city(): BelongsTo
    {
        return $this->belongsTo(City::class);
    }
}
