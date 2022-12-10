<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\{Model,SoftDeletes};

class ProductoVenta extends Model
{
    use HasFactory,SoftDeletes;
    protected $table = 'producto_venta';
}
