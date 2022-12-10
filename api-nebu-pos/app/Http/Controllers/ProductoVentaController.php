<?php

namespace App\Http\Controllers;

use App\Models\ProductoVenta;
use App\Http\Requests\StoreProductoVentaRequest;
use App\Http\Requests\UpdateProductoVentaRequest;

class ProductoVentaController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreProductoVentaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreProductoVentaRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ProductoVenta  $productoVenta
     * @return \Illuminate\Http\Response
     */
    public function show(ProductoVenta $productoVenta)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateProductoVentaRequest  $request
     * @param  \App\Models\ProductoVenta  $productoVenta
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateProductoVentaRequest $request, ProductoVenta $productoVenta)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ProductoVenta  $productoVenta
     * @return \Illuminate\Http\Response
     */
    public function destroy(ProductoVenta $productoVenta)
    {
        //
    }
}
