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
        return ServicioCategoria::all()->load('servicios');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreServicioCategoriaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreServicioCategoriaRequest $request)
    {
        $servicioCategoria = new ServicioCategoria();
        $servicioCategoria->nombre = $request->nombre;
        $servicioCategoria->save();
        return $servicioCategoria;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ServicioCategoria  $servicioCategoria
     * @return \Illuminate\Http\Response
     */
    public function show(ServicioCategoria $servicioCategoria)
    {
        return $servicioCategoria->load('servicios');
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
        $servicioCategoria->nombre = $request->nombre;
        $servicioCategoria->save();
        return $servicioCategoria;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ServicioCategoria  $servicioCategoria
     * @return \Illuminate\Http\Response
     */
    public function destroy(ServicioCategoria $servicioCategoria)
    {
        $servicioCategoria->delete();
    }
}
