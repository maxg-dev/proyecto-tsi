<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('servicio_venta', function (Blueprint $table) {
            $table->foreignId('servicio_id')->constrained();
            $table->foreignId('venta_id')->constrained();
            $table->primary(['servicio_id','venta_id']);
            $table->integer('cantidad');
            $table->integer('precio_venta');
            $table->integer('descuento');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('servicio_venta');
    }
};
