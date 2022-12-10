<?php

namespace App\Http\Controllers;

use App\Models\ProductoCategoria;
use Illuminate\Http\Request;

class ProductoCategoriaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ProductoCategoria::all()->load('productos');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $productoCategoria = new ProductoCategoria();
        $productoCategoria->nombre = $request->nombre;
        $productoCategoria->save();
        return $productoCategoria;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ProductoCategoria  $productoCategoria
     * @return \Illuminate\Http\Response
     */
    public function show(ProductoCategoria $productoCategoria)
    {
        return $productoCategoria->load('productos');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\ProductoCategoria  $productoCategoria
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ProductoCategoria $productoCategoria)
    {
        $productoCategoria->nombre = $request->nombre;
        $productoCategoria->save();
        return $productoCategoria;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ProductoCategoria  $productoCategoria
     * @return \Illuminate\Http\Response
     */
    public function destroy(ProductoCategoria $productoCategoria)
    {
        $productoCategoria->delete();
    }
}
