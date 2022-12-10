<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\{
    AjusteController
    ,ClienteController,DeudaController,ProductoController
    ,ServicioController,VentaController,ProductoCategoriaController
    ,ServicioCategoriaController,ProductoVentaController
    ,ServicioVentaController,DeudaVentaController
};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::apiResource('/ajustes',AjusteController::class);
Route::apiResource('/clientes',ClienteController::class);
Route::apiResource('/deudas',DeudaController::class);
Route::apiResource('/productos',ProductoController::class);
Route::apiResource('/servicios',ServicioController::class);
Route::apiResource('/ventas',VentaController::class);
Route::apiResource('/productoCategorias',ProductoCategoriaController::class);
Route::apiResource('/servicioCategorias',ServicioCategoriaController::class);
Route::apiResource('/productoVentas',ProductoVentaController::class);
Route::apiResource('/servicioVentas',ServicioVentaController::class);
Route::apiResource('/deudaVentas',DeudaVentaController::class);