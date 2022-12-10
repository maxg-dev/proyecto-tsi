<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model,SoftDeletes};

class ServicioCategoria extends Model
{
    use HasFactory,SoftDeletes;

    public function servicios(){
        return $this->hasMany(Servicio::class);
    }
}
