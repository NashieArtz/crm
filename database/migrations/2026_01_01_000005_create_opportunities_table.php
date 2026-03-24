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
        Schema::create('opportunities', function (Blueprint $table) {
            $table->id('id_opportunity');
            $table->string('source', 100)->nullable();
            $table->text('details')->nullable();
            $table->enum('status', [
                'qualification',
                'proposal',
                'negotiation',
                'closed_won',
                'closed_lost',
            ]);
            $table->enum('type', [
                'new_business',
                'upsell',
                'renewal',
            ]);
            $table->decimal('amount', 15, 2)->nullable();
            $table->dateTime('closed_date');
            $table->foreignId('client_id')->constrained('clients', 'id_client')->cascadeOnDelete();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('opportunities');
    }
};
