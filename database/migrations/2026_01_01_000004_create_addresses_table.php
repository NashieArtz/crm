<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('addresses', function (Blueprint $table) {
            $table->id('id_address');
            $table->string('street', 100)->nullable();
            $table->integer('number')->nullable();
            $table->string('postal_code', 30)->nullable();
            $table->string('complement', 100)->nullable();
            $table->foreignId('client_id')->constrained('clients', 'id_client')->cascadeOnDelete();
            $table->foreignId('city_id')->constrained('cities', 'id_city')->cascadeOnDelete();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('addresses');
    }
};
