<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model,SoftDeletes};

class Cliente extends Model
{
    use HasFactory,SoftDeletes;

    public function ventas()
    {
        return $this->hasMany(Venta::class);
    }
}
