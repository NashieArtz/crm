<?php

namespace App\Observers;

use App\Models\Activity;
use App\Models\Opportunity;

class OpportunityObserver
{
    /**
     * Handle the Opportunity "created" event.
     */
    public function creating(Opportunity $opportunity): void
    {
        // definit une date par defaut
        if (empty($opportunity->closed_date)) {
            $opportunity->closed_date = now()->addDays(30);
        }
    }

    /**
     * Handle the Opportunity "updated" event.
     */
    public function updated(Opportunity $opportunity): void
    {
        // vérification si donné ont été modifié durant requête
        if ($opportunity->isDirty('status')) {

            // Récupération ancien et nouveau statut
            $oldStatus = $opportunity->getOriginal('status');
            $newStatus = $opportunity->status;

            // Trace de l'activité
            $activity = Activity::create([
                'type' => 'note',
                'description' => "Changement de statut de l'opportunité automatique : de '{$oldStatus}' à '{$newStatus}'.",
                'date_activity' => now(),
            ]);

            // Lier au client concerné
            $activity->clients()->attach($opportunity->client_id);
        }
    }

    /**
     * Handle the Opportunity "deleted" event.
     */
    public function deleted(Opportunity $opportunity): void
    {
        //
    }

    /**
     * Handle the Opportunity "restored" event.
     */
    public function restored(Opportunity $opportunity): void
    {
        //
    }

    /**
     * Handle the Opportunity "force deleted" event.
     */
    public function forceDeleted(Opportunity $opportunity): void
    {
        //
    }
}
