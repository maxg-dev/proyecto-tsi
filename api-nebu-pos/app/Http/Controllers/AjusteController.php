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
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \App\Http\Requests\StoreAjusteRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreAjusteRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Ajuste  $ajuste
     * @return \Illuminate\Http\Response
     */
    public function show(Ajuste $ajuste)
    {
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Ajuste  $ajuste
     * @return \Illuminate\Http\Response
     */
    public function destroy(Ajuste $ajuste)
    {
        //
    }
}
