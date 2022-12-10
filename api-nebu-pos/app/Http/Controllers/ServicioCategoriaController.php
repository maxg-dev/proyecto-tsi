<?php

namespace App\Http\Controllers;

use App\Models\ServicioCategoria;
use App\Http\Requests\StoreServicioCategoriaRequest;
use App\Http\Requests\UpdateServicioCategoriaRequest;

class ServicioCategoriaController extends Controller
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
     * @param  \App\Http\Requests\StoreServicioCategoriaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreServicioCategoriaRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ServicioCategoria  $servicioCategoria
     * @return \Illuminate\Http\Response
     */
    public function show(ServicioCategoria $servicioCategoria)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateServicioCategoriaRequest  $request
     * @param  \App\Models\ServicioCategoria  $servicioCategoria
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateServicioCategoriaRequest $request, ServicioCategoria $servicioCategoria)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ServicioCategoria  $servicioCategoria
     * @return \Illuminate\Http\Response
     */
    public function destroy(ServicioCategoria $servicioCategoria)
    {
        //
    }
}
