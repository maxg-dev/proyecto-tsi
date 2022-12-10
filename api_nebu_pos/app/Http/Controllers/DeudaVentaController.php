<?php

namespace App\Http\Controllers;

use App\Models\DeudaVenta;
use App\Http\Requests\StoreDeudaVentaRequest;
use App\Http\Requests\UpdateDeudaVentaRequest;

class DeudaVentaController extends Controller
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
     * @param  \App\Http\Requests\StoreDeudaVentaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreDeudaVentaRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\DeudaVenta  $deudaVenta
     * @return \Illuminate\Http\Response
     */
    public function show(DeudaVenta $deudaVenta)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateDeudaVentaRequest  $request
     * @param  \App\Models\DeudaVenta  $deudaVenta
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateDeudaVentaRequest $request, DeudaVenta $deudaVenta)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\DeudaVenta  $deudaVenta
     * @return \Illuminate\Http\Response
     */
    public function destroy(DeudaVenta $deudaVenta)
    {
        //
    }
}
