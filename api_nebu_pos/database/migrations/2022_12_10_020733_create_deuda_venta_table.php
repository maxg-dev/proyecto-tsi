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
        Schema::create('deuda_venta', function (Blueprint $table) {
            $table->foreignId('deuda_id')->constrained();
            $table->foreignId('venta_id')->constrained();

            $table->primary(['deuda_id','venta_id']);
            $table->integer('precio_venta');

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
        Schema::dropIfExists('deuda_venta');
    }
};
