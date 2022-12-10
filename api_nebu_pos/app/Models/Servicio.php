<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model,SoftDeletes};

class Servicio extends Model
{
    use HasFactory,SoftDeletes;
    public function servicioCategoria(){
        return $this->belongsTo(ServicioCategoria::class);
    }
    public function ventas(){
        return $this->belongsToMany(Venta::class)->withPivot('cantidad','precio_venta','descuento');
    }
}
