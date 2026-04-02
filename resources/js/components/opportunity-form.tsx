import { useForm } from '@inertiajs/react';
import React from 'react';

interface OpportunityFormProps {
    clientId: number;
    onSuccess?: () => void;
}

export function OpportunityForm({ clientId, onSuccess }: OpportunityFormProps) {
    const { data, setData, post, processing, errors, reset } = useForm({
        client_id: clientId,
        details: '',
        source: '',
        amount: '',
        closed_date: '',
        status: 'qualification',
        type: 'new_business',
    });

    const submitOpportunity = (e: React.FormEvent) => {
        e.preventDefault();
        post('/opportunities', {
            preserveScroll: true,
            onSuccess: () => {
                reset();

                if (onSuccess) {
                    onSuccess();
                }
            },
        });
    };

    return (
        <form onSubmit={submitOpportunity} className="mb-6 grid grid-cols-1 gap-4 rounded-lg bg-muted/30 p-4 md:grid-cols-2">

            {/* Description*/}
            <div className="col-span-1 md:col-span-2">
                <label className="mb-1 block text-xs font-medium text-muted-foreground">Description du besoin</label>
                <input
                    type="text"
                    placeholder="Ex: Refonte complète du site web..."
                    value={data.details}
                    onChange={e => setData('details', e.target.value)}
                    required
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            {/* Source & Montant */}
            <div className="flex flex-col gap-1">
                <label className="block text-xs font-medium text-muted-foreground">Source</label>
                <input
                    type="text"
                    placeholder="Ex: LinkedIn, Site Web, Recommandation"
                    value={data.source}
                    onChange={e => setData('source', e.target.value)}
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            <div className="flex flex-col gap-1">
                <label className="block text-xs font-medium text-muted-foreground">Montant estimé (€)</label>
                <input
                    type="number"
                    step="0.01"
                    min="0"
                    placeholder="Ex: 15000"
                    value={data.amount}
                    onChange={e => setData('amount', e.target.value)}
                    required
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            {/* Statut & Type */}
            <div className="flex flex-col gap-1">
                <label className="block text-xs font-medium text-muted-foreground">Statut</label>
                <select
                    value={data.status}
                    onChange={e => setData('status', e.target.value)}
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                >
                    <option value="qualification">Qualification</option>
                    <option value="proposal">Proposition envoyée</option>
                    <option value="negotiation">En Négociation</option>
                    <option value="closed_won">Gagnée (Fermée)</option>
                    <option value="closed_lost">Perdue (Fermée)</option>
                </select>
            </div>

            <div className="flex flex-col gap-1">
                <label className="block text-xs font-medium text-muted-foreground">Type de contrat</label>
                <select
                    value={data.type}
                    onChange={e => setData('type', e.target.value)}
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                >
                    <option value="new_business">Nouveau Client (New Business)</option>
                    <option value="upsell">Vente Additionnelle (Upsell)</option>
                    <option value="renewal">Renouvellement (Renewal)</option>
                </select>
            </div>

            {/* Enregistrer */}
            <div className="flex flex-col gap-1">
                <label className="block text-xs font-medium text-muted-foreground">Date de clôture (Prévue ou Réelle)</label>
                <input
                    type="date"
                    value={data.closed_date}
                    onChange={e => setData('closed_date', e.target.value)}
                    required
                    className="w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
                />
            </div>

            <div className="flex items-end justify-end">
                <button
                    type="submit"
                    disabled={processing}
                    className="w-full md:w-auto rounded-md bg-primary px-6 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
                >
                    Enregistrer l'opportunité
                </button>
            </div>

            {/* Erreurs */}
            {Object.keys(errors).length > 0 && (
                <p className="col-span-full text-xs text-destructive">
                    Veuillez vérifier les champs. Assurez-vous que le montant et la date sont valides.
                </p>
            )}
        </form>
    );
}
