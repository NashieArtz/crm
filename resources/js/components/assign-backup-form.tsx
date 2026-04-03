import { useForm } from '@inertiajs/react';
import React from 'react';

interface AssignBackupFormProps {
    clientId: number;
    users: any[];
    currentUsers: any[];
    onSuccess: () => void;
    onCancel: () => void;
}

export function AssignBackupForm({
    clientId,
    users,
    currentUsers,
    onSuccess,
    onCancel,
}: AssignBackupFormProps) {
    const { data, setData, post, processing, errors } = useForm({
        user_id: '',
    });

    // Ne garder que les utilisateurs non assignés au client
    const availableUsers = users.filter(
        (u) => !currentUsers.some((cu) => cu.id_user === u.id_user),
    );

    const submit = (e: React.FormEvent) => {
        e.preventDefault();
        post(`/clients/${clientId}/backup`, {
            preserveScroll: true,
            onSuccess: () => onSuccess(),
        });
    };

    return (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4 backdrop-blur-sm">
            <form
                onSubmit={submit}
                className="w-full max-w-md rounded-xl bg-card p-6 shadow-lg"
            >
                <h2 className="mb-4 text-lg font-bold">
                    Assigner un commercial
                </h2>

                <div className="mb-6 flex flex-col gap-1">
                    <label className="text-sm font-medium text-muted-foreground">
                        Sélectionner un utilisateur
                    </label>
                    <select
                        value={data.user_id}
                        onChange={(e) => setData('user_id', e.target.value)}
                        required
                        className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                    >
                        <option value="" disabled>
                            Choisir un profil...
                        </option>
                        {availableUsers.length === 0 && (
                            <option value="" disabled>
                                Aucun profil disponible
                            </option>
                        )}
                        {availableUsers.map((u) => (
                            <option key={u.id_user} value={u.id_user}>
                                {u.name} ({u.email})
                            </option>
                        ))}
                    </select>
                    {errors.user_id && (
                        <p className="text-xs text-destructive">
                            {errors.user_id}
                        </p>
                    )}
                </div>

                <div className="flex justify-end gap-3">
                    <button
                        type="button"
                        onClick={onCancel}
                        className="rounded-md border border-input bg-background px-4 py-2 text-sm font-medium hover:bg-accent"
                    >
                        Annuler
                    </button>
                    <button
                        type="submit"
                        disabled={processing || !data.user_id}
                        className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
                    >
                        Assigner
                    </button>
                </div>
            </form>
        </div>
    );
}
