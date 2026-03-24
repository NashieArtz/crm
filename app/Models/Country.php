<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Country extends Model
{

    protected $primaryKey = 'id_country';

    protected $fillable = [
        'name',
    ];

    // Un country a plusieurs villes
    public function cities(): HasMany
    {
        return $this->hasMany(City::class, 'country_id', 'id_country');
    }
}
