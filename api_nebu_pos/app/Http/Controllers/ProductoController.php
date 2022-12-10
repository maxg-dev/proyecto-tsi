<?php

namespace App\Http\Controllers;

use App\Models\Producto;
use App\Http\Requests\StoreProductoRequest;
use App\Http\Requests\UpdateProductoRequest;

class ProductoController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Producto::all()->load(['ajustes','ventas','productoCategoria']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreProductoRequest $request)
    {
        $producto = new Producto();
        $producto->tipo = $request->tipo;
        $producto->nombre = $request->nombre;
        $producto->precio = $request->precio;
        $producto->costo = $request->costo;
        $producto->stock = $request->stock;
        $producto->stock_min = $request->stock_min;
        $producto->estado = $request->estado;
        $producto->descripcion = $request->descripcion;
        $producto->producto_categoria_id = $request->producto_categoria_id;
        $producto->save();
        return $producto;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Producto  $producto
     * @return \Illuminate\Http\Response
     */
    public function show(Producto $producto)
    {
        return $producto->load(['ajustes','ventas','productoCategoria']);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Producto  $producto
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateProductoRequest $request, Producto $producto)
    {
        $producto->tipo = $request->tipo;
        $producto->nombre = $request->nombre;
        $producto->precio = $request->precio;
        $producto->costo = $request->costo;
        $producto->stock = $request->stock;
        $producto->stock_min = $request->stock_min;
        $producto->estado = $request->estado;
        $producto->descripcion = $request->descripcion;
        $producto->producto_categoria_id = $request->producto_categoria_id;
        $producto->save();
        return $producto;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Producto  $producto
     * @return \Illuminate\Http\Response
     */
    public function destroy(Producto $producto)
    {
        $producto->delete();
    }
}
