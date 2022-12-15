<?php

namespace App\Http\Controllers;

use App\Models\Ajuste;
use App\Http\Requests\StoreAjusteRequest;
use App\Http\Requests\UpdateAjusteRequest;

class AjusteController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return Ajuste::all()->load('producto');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreAjusteRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreAjusteRequest $request)
    {
        $ajuste = new Ajuste();
        $ajuste->tipo = $request->tipo;
        $ajuste->cantidad = $request->cantidad;
        $ajuste->descripcion = $request->descripcion;
        $ajuste->producto_id = $request->producto_id;
        $ajuste->save();
        return $ajuste;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Ajuste  $ajuste
     * @return \Illuminate\Http\Response
     */
    public function show(Ajuste $ajuste)
    {
        return $ajuste->load('producto');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateAjusteRequest  $request
     * @param  \App\Models\Ajuste  $ajuste
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateAjusteRequest $request, Ajuste $ajuste)
    {
        $ajuste->tipo_ajuste = $request->tipo_ajuste;
        $ajuste->cantidad = $request->cantidad;
        $ajuste->descripcion = $request->descripcion;
        $ajuste->producto_id = $request->producto_id;
        $ajuste->save();
        return $ajuste;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Ajuste  $ajuste
     * @return \Illuminate\Http\Response
     */
    public function destroy(Ajuste $ajuste)
    {
        $ajuste->destroy();
    }
}
