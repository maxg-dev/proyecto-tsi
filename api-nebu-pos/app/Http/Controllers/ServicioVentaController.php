<?php

namespace App\Http\Controllers;

use App\Models\ServicioVenta;
use App\Http\Requests\StoreServicioVentaRequest;
use App\Http\Requests\UpdateServicioVentaRequest;

class ServicioVentaController extends Controller
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
     * @param  \App\Http\Requests\StoreServicioVentaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreServicioVentaRequest $request)
    {
        $servicioVenta = new ServicioVenta();
        $servicioVenta->servicio_id = $request->servicio_id;
        $servicioVenta->venta_id = $request->venta_id;
        $servicioVenta->cantidad = $request->cantidad;
        $servicioVenta->precio_venta = $request->precio_venta;
        $servicioVenta->descuento = $request->descuento;
        $servicioVenta->save();
        return $servicioVenta;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ServicioVenta  $servicioVenta
     * @return \Illuminate\Http\Response
     */
    public function show(ServicioVenta $servicioVenta)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateServicioVentaRequest  $request
     * @param  \App\Models\ServicioVenta  $servicioVenta
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateServicioVentaRequest $request, ServicioVenta $servicioVenta)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ServicioVenta  $servicioVenta
     * @return \Illuminate\Http\Response
     */
    public function destroy(ServicioVenta $servicioVenta)
    {
        $servicioVenta->delete();
    }
}
