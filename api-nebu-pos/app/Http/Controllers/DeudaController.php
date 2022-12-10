<?php

namespace App\Http\Controllers;

use App\Models\Deuda;
use App\Http\Requests\StoreDeudaRequest;
use App\Http\Requests\UpdateDeudaRequest;

class DeudaController extends Controller
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
     * @param  \App\Http\Requests\StoreDeudaRequest  $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreDeudaRequest $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Deuda  $deuda
     * @return \Illuminate\Http\Response
     */
    public function show(Deuda $deuda)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \App\Http\Requests\UpdateDeudaRequest  $request
     * @param  \App\Models\Deuda  $deuda
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateDeudaRequest $request, Deuda $deuda)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Deuda  $deuda
     * @return \Illuminate\Http\Response
     */
    public function destroy(Deuda $deuda)
    {
        //
    }
}
