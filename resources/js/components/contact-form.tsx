import { useForm } from '@inertiajs/react';
import React from 'react';
interface ContactFormProps {
    clientId: number;
    onSuccess?: () => void;
}

export function ContactForm({ clientId, onSuccess }: ContactFormProps) {
    const { data, setData, post, processing, errors, reset } = useForm({
        client_id: clientId,
        first_name: '',
        last_name: '',
        email: '',
        phone: '',
        type: '',
        description: '',
    });

    const submitContact = (e: React.FormEvent) => {
        e.preventDefault();
        post('/contacts', {
            preserveScroll: true,
            onSuccess: () => {
                // Vider le formulaire
                reset();

                if (onSuccess) {
                    onSuccess();
                }
            },
        });
    };

    return (
        <form
            onSubmit={submitContact}
            className="mb-6 grid grid-cols-1 gap-4 rounded-lg bg-muted/30 p-4 md:grid-cols-5"
        >
            <div className="col-span-1 flex gap-4 md:col-span-2">
                <input
                    type="text"
                    placeholder="Prénom"
                    value={data.first_name}
                    onChange={(e) => setData('first_name', e.target.value)}
                    required
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
                <input
                    type="text"
                    placeholder="Nom"
                    value={data.last_name}
                    onChange={(e) => setData('last_name', e.target.value)}
                    required
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            <input
                type="text"
                placeholder="Poste (ex: DSI)"
                value={data.description}
                onChange={(e) => setData('description', e.target.value)}
                className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
            />

            <select
                value={data.type}
                onChange={(e) => setData('type', e.target.value)}
                className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
            >
                <option value="lead">Lead</option>
                <option value="prospect">Prospect</option>
                <option value="customer">Client</option>
                <option value="partner">Partenaire</option>
            </select>

            <input
                type="email"
                placeholder="Email"
                value={data.email}
                onChange={(e) => setData('email', e.target.value)}
                className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
            />

            <div className="col-span-1 flex gap-4 md:col-span-2 lg:col-span-2">
                <input
                    type="text"
                    placeholder="Téléphone"
                    value={data.phone}
                    onChange={(e) => setData('phone', e.target.value)}
                    className="rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
                <button
                    type="submit"
                    // Empêcher 15 clics d'affilés
                    disabled={processing}
                    className="rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
                >
                    Enregistrer
                </button>
            </div>

            {(errors.first_name ||
                errors.last_name ||
                errors.email ||
                errors.type) && (
                <p className="col-span-full text-xs text-destructive">
                    Veuillez vérifier vos champs de saisie.
                </p>
            )}
        </form>
    );
}
