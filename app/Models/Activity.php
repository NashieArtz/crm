<?php

namespace App\Models;

use Database\Factories\ActivityFactory;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Activity extends Model
{
    /** @use HasFactory<ActivityFactory> */
    use HasFactory;

    protected $primaryKey = 'id_activity';

    protected $fillable = [
        'type',
        'description',
        'date_activity',
    ];

    public function clients(): BelongsToMany
    {
        return $this->belongsToMany(Client::class, 'activity_client', 'activity_id', 'client_id');
    }
}
