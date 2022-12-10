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
        Schema::create('productos', function (Blueprint $table) {
            $table->id();
            $table->boolean('tipo');
            $table->string('nombre',50);
            $table->integer('precio');
            $table->integer('costo');
            $table->integer('stock');
            $table->integer('stock_min');
            $table->boolean('estado');
            $table->string('descripcion',100);
            $table->foreignId('producto_categoria_id')->constrained();
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
        Schema::dropIfExists('productos');
    }
};
