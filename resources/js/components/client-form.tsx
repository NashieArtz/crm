import { useForm } from '@inertiajs/react';
import { Plus, Trash2 } from 'lucide-react';
import React from 'react';

interface ClientFormProps {
    client?: any;
    onSuccess?: () => void;
}

export function ClientForm({ client, onSuccess }: ClientFormProps) {
    const { data, setData, post, put, processing, errors, reset } = useForm({
        company_name: client?.company_name || '',
        email: client?.email || '',
        phone: client?.phone || '',
        website: client?.website || '',
        income: client?.income || '',
        contacts: [],
    });

    const addContact = () => {
        setData('contacts', [
            ...data.contacts,
            {
                first_name: '',
                last_name: '',
                email: '',
                phone: '',
                type: 'prospect',
                description: '',
            },
        ]);
    };

    // Supprimer une ligne de contact
    const removeContact = (index: number) => {
        const newContacts = [...data.contacts];
        newContacts.splice(index, 1);
        setData('contacts', newContacts);
    };

    // Mettre à jour un champ spécifique d'un contact spécifique
    const updateContact = (index: number, field: string, value: string) => {
        const newContacts = [...data.contacts];

        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-expect-error
        newContacts[index][field] = value;
        setData('contacts', newContacts);
    };

    const submitClient = (e: React.FormEvent) => {
        e.preventDefault();

        const options = {
            preserveScroll: true,
            onSuccess: () => {
                reset();

                if (onSuccess) {
                    onSuccess();
                }
            },
        };

        if (client) {
            put(`/clients/${client.id_client}`, options);
        } else {
            post('/clients', options);
        }
    };

    return (
        <form
            onSubmit={submitClient}
            className="mb-8 rounded-xl border bg-card p-6 text-card-foreground shadow-sm"
        >
            {/* --- SECTION 1 : INFORMATIONS DE L'ENTREPRISE --- */}
            <div className="mb-6 border-b pb-4">
                <h2 className="mb-4 text-lg font-bold">
                    1. Informations de l'entreprise
                </h2>
                <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
                    <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-muted-foreground">
                            Nom de l'entreprise *
                        </label>
                        <input
                            type="text"
                            value={data.company_name}
                            onChange={(e) =>
                                setData('company_name', e.target.value)
                            }
                            required
                            className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                        />
                        {errors.company_name && (
                            <p className="text-xs text-destructive">
                                {errors.company_name}
                            </p>
                        )}
                    </div>

                    <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-muted-foreground">
                            Adresse Email (Générale) *
                        </label>
                        <input
                            type="email"
                            value={data.email}
                            onChange={(e) => setData('email', e.target.value)}
                            required
                            className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                        />
                        {errors.email && (
                            <p className="text-xs text-destructive">
                                {errors.email}
                            </p>
                        )}
                    </div>

                    <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-muted-foreground">
                            Téléphone
                        </label>
                        <input
                            type="text"
                            value={data.phone}
                            onChange={(e) => setData('phone', e.target.value)}
                            className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                        />
                    </div>

                    <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-muted-foreground">
                            Site Web
                        </label>
                        <input
                            type="url"
                            value={data.website}
                            onChange={(e) => setData('website', e.target.value)}
                            className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                        />
                    </div>

                    <div className="flex flex-col gap-1">
                        <label className="text-xs font-medium text-muted-foreground">
                            Revenu Annuel Estimé (€)
                        </label>
                        <input
                            type="number"
                            min="0"
                            value={data.income}
                            onChange={(e) => setData('income', e.target.value)}
                            className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                        />
                    </div>
                </div>
            </div>

            {/* Contacts*/}
            <div className="mb-6">
                <div className="mb-4 flex items-center justify-between">
                    <h2 className="text-lg font-bold">
                        2. Contacts associés (Optionnel)
                    </h2>
                    <button
                        type="button"
                        onClick={addContact}
                        className="inline-flex items-center gap-1 rounded-md bg-secondary px-3 py-1.5 text-xs font-medium text-secondary-foreground hover:bg-secondary/80"
                    >
                        <Plus size={14} /> Ajouter un contact
                    </button>
                </div>

                <div className="space-y-4">
                    {/* Boucle sur le tableau des contacts pour générer les champs */}
                    {data.contacts.map((contact, index) => (
                        <div
                            key={index}
                            className="relative grid grid-cols-1 gap-4 rounded-lg bg-muted/30 p-4 md:grid-cols-5"
                        >
                            {/* Suppression contact */}
                            {data.contacts.length > 0 && (
                                <button
                                    type="button"
                                    onClick={() => removeContact(index)}
                                    className="absolute top-2 right-2 text-muted-foreground hover:text-destructive"
                                >
                                    <Trash2 size={16} />
                                </button>
                            )}

                            <div className="col-span-1 flex gap-2 md:col-span-2">
                                <input
                                    type="text"
                                    placeholder="Prénom *"
                                    required
                                    value={contact.first_name}
                                    onChange={(e) =>
                                        updateContact(
                                            index,
                                            'first_name',
                                            e.target.value,
                                        )
                                    }
                                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                                />
                                <input
                                    type="text"
                                    placeholder="Nom *"
                                    required
                                    value={contact.last_name}
                                    onChange={(e) =>
                                        updateContact(
                                            index,
                                            'last_name',
                                            e.target.value,
                                        )
                                    }
                                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                                />
                            </div>

                            <input
                                type="text"
                                placeholder="Poste (ex: DSI)"
                                value={contact.description}
                                onChange={(e) =>
                                    updateContact(
                                        index,
                                        'description',
                                        e.target.value,
                                    )
                                }
                                className="col-span-1 w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                            />

                            <select
                                value={contact.type}
                                onChange={(e) =>
                                    updateContact(index, 'type', e.target.value)
                                }
                                className="col-span-1 w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                            >
                                <option value="lead">Lead</option>
                                <option value="prospect">Prospect</option>
                                <option value="customer">Client</option>
                                <option value="partner">Partenaire</option>
                            </select>

                            <div className="col-span-1 flex flex-col gap-2 md:col-span-5 md:flex-row">
                                <input
                                    type="email"
                                    placeholder="Email direct"
                                    value={contact.email}
                                    onChange={(e) =>
                                        updateContact(
                                            index,
                                            'email',
                                            e.target.value,
                                        )
                                    }
                                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm md:w-1/2"
                                />
                                <input
                                    type="text"
                                    placeholder="Ligne directe"
                                    value={contact.phone}
                                    onChange={(e) =>
                                        updateContact(
                                            index,
                                            'phone',
                                            e.target.value,
                                        )
                                    }
                                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm md:w-1/2"
                                />
                            </div>

                            {/* erreurs */}
                            {errors[
                                `contacts.${index}.first_name` as keyof typeof errors
                            ] && (
                                <p className="col-span-full text-xs text-destructive">
                                    Erreur sur le contact {index + 1}.
                                </p>
                            )}
                        </div>
                    ))}
                </div>
            </div>

            {/* bouton annuler */}
            <div className="flex items-center justify-end gap-3 border-t pt-4">
                <button
                    type="button"
                    onClick={onSuccess}
                    className="rounded-md border border-input bg-background px-4 py-2 text-sm font-medium hover:bg-accent hover:text-accent-foreground"
                >
                    Annuler
                </button>
                <button
                    type="submit"
                    disabled={processing}
                    className="rounded-md bg-primary px-6 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
                >
                    {client ? 'Mettre à jour' : 'Créer le dossier complet'}
                </button>
            </div>
        </form>
    );
}
