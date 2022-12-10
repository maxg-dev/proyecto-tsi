<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model,SoftDeletes};

class Producto extends Model
{
    use HasFactory, SoftDeletes;

    public function productoCategoria(){
        return $this->belongsTo(ProductoCategoria::class);
    }

    public function ajustes(){
        return $this->hasMany(Ajuste::class);
    }

    public function ventas(){
        return $this->belongsToMany(Venta::class)->withPivot('cantidad','precio_venta','descuento');
    }
}
