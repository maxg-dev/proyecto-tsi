<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model,SoftDeletes};

class Venta extends Model
{
    use HasFactory,SoftDeletes;
    protected $appends = ['total_venta'];


    public function cliente(){
        return $this->belongsTo(Cliente::class);
    }
    public function productos(){
        return $this->belongsToMany(Producto::class)->withPivot('cantidad','precio_venta','descuento');
    }
    public function servicios(){
        return $this->belongsToMany(Servicio::class)->withPivot('cantidad','precio_venta','descuento');
    }

    public function getTotalVentaAttribute(){
        $totalVenta = 0;
        foreach($this->productos as $producto){
            if($producto->estado == 1){
                $totalVenta += $producto->pivot->cantidad * ($producto->pivot->precio_venta - $producto->pivot->descuento);
            }
        }
        foreach($this->servicios as $servicio){
            if($servicio->estado == 1){
                $totalVenta += $servicio->pivot->cantidad * ($servicio->pivot->precio_venta - $servicio->pivot->descuento);
            }
        }
        return $totalVenta;
    }
}
