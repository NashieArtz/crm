import { useForm } from '@inertiajs/react';
import React from 'react';

interface ActivityFormProps {
    clientId: number;
    activity?: any;
    onSuccess?: () => void;
}

export function ActivityForm({
    clientId,
    activity,
    onSuccess,
}: ActivityFormProps) {
    const now = new Date();

    // Fuseau horaire
    const localDateTime = new Date(
        now.getTime() - now.getTimezoneOffset() * 60000,
    )
        .toISOString()
        .slice(0, 16);

    const formatEditDate = activity?.date_activity
        ? new Date(
              new Date(activity.date_activity).getTime() -
                  new Date().getTimezoneOffset() * 60000,
          )
              .toISOString()
              .slice(0, 16)
        : localDateTime;

    const { data, setData, post, put, processing, errors, reset } = useForm({
        client_id: clientId,
        type: activity?.type || 'call',
        description: activity?.description || '',
        date_activity: formatEditDate,
    });

    const submitActivity = (e: React.FormEvent) => {
        e.preventDefault();

        const options = {
            preserveScroll: true,
            onSuccess: () => {
                // Reset que de la description, keep date et heure
                reset('description');

                if (onSuccess) {
                    onSuccess();
                }
            },
        };

        if (activity) {
            put(`/activities/${activity.id_activity}`, options);
        } else {
            post('/activities', options);
        }
    };

    return (
        <form
            onSubmit={submitActivity}
            className="mb-6 grid grid-cols-1 gap-4 rounded-lg bg-muted/30 p-4 md:grid-cols-2"
        >
            <div className="col-span-1 mb-2 flex items-center justify-between md:col-span-2">
                <h3 className="text-sm font-bold">
                    {activity ? "Modifier l'activité" : 'Ajouter une activité'}
                </h3>
                {activity && (
                    <button
                        type="button"
                        onClick={onSuccess}
                        className="text-xs text-muted-foreground hover:text-foreground"
                    >
                        Annuler
                    </button>
                )}
            </div>

            {/* Type d'activité */}
            <div className="flex flex-col gap-1">
                <label className="text-xs font-medium text-muted-foreground">
                    Type d'interaction
                </label>
                <select
                    value={data.type}
                    onChange={(e) => setData('type', e.target.value)}
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                >
                    <option value="call">Appel téléphonique</option>
                    <option value="email">Email</option>
                    <option value="meeting">Réunion</option>
                    <option value="task">Tâche / À faire</option>
                    <option value="note">Note interne</option>
                </select>
            </div>

            {/* Date et Heure */}
            <div className="flex flex-col gap-1">
                <label className="text-xs font-medium text-muted-foreground">
                    Date et Heure
                </label>
                <input
                    type="datetime-local"
                    value={data.date_activity}
                    onChange={(e) => setData('date_activity', e.target.value)}
                    required
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            {/* Description */}
            <div className="col-span-1 flex flex-col gap-1 md:col-span-2">
                <label className="text-xs font-medium text-muted-foreground">
                    Compte-rendu / Détails
                </label>
                <textarea
                    placeholder="Saisissez les détails de l'échange ou de la tâche..."
                    value={data.description}
                    onChange={(e) => setData('description', e.target.value)}
                    required
                    rows={3}
                    className="w-full resize-none rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            <div className="col-span-1 flex items-end justify-end md:col-span-2">
                <button
                    type="submit"
                    disabled={processing}
                    className="w-full rounded-md bg-primary px-6 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50 md:w-auto"
                >
                    {activity ? 'Mettre à jour' : "Enregistrer l'activité"}
                </button>
            </div>

            {Object.keys(errors).length > 0 && (
                <p className="col-span-full text-xs text-destructive">
                    Veuillez vérifier vos champs de saisie.
                </p>
            )}
        </form>
    );
}
