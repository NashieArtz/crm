<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Role extends Model
{
    protected $primaryKey = 'id_role';

    protected $fillable = [
        'rolename',
    ];

    public function users(): HasMany
    {
        return $this->HasMany(User::class, 'role_id', 'id_role');
    }
}
