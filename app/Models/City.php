<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class City extends Model
{
    protected $primaryKey = 'id_city';
    protected $fillable = [
        'name',
        'country_id',
    ];

    // Une ville appartient à plusieurs adresses

    public function addresses(): HasMany
    {
        return $this->hasMany(Address::class);
    }

    // Une ville appartient à un seul pays
    public function country(): BelongsTo
    {
        return $this->belongsTo(Country::class);
    }
}
