import { Head, useForm } from '@inertiajs/react';
import { Settings as SettingsIcon, Save } from 'lucide-react';
import React from 'react';
import AppLayout from '@/layouts/app-layout';
import type { BreadcrumbItem } from '@/types';

export default function Index({ settings }: { settings: any }) {
    const breadcrumbs: BreadcrumbItem[] = [
        { title: 'Administration', href: '#' },
        { title: 'Paramètres', href: '/admin/settings' },
    ];

    // Initialisation du formulaire avec les paramètres de la BDD ou des valeurs par défaut
    const { data, setData, post, processing, errors } = useForm({
        company_name: settings?.company_name || '',
        support_email: settings?.support_email || '',
        currency: settings?.currency || 'EUR',
    });

    const submit = (e: React.FormEvent) => {
        e.preventDefault();
        post('/admin/settings', { preserveScroll: true });
    };

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Paramètres CRM" />

            <div className="mx-auto w-full max-w-4xl p-6">
                <div className="mb-6 border-b pb-4">
                    <h1 className="flex items-center gap-2 text-2xl font-bold">
                        <SettingsIcon size={24} className="text-primary" />{' '}
                        Paramètres Globaux
                    </h1>
                    <p className="mt-1 text-sm text-muted-foreground">
                        Ces paramètres s'appliquent à l'ensemble de la
                        plateforme et de l'équipe.
                    </p>
                </div>

                <form
                    onSubmit={submit}
                    className="space-y-6 rounded-xl border bg-card p-6 shadow-sm"
                >
                    <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
                        {/* Paramètre 1 */}
                        <div className="flex flex-col gap-1.5">
                            <label className="text-sm font-semibold">
                                Nom de l'entreprise
                            </label>
                            <input
                                type="text"
                                value={data.company_name}
                                onChange={(e) =>
                                    setData('company_name', e.target.value)
                                }
                                placeholder="Ex: MonSuperCRM"
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                            />
                        </div>

                        {/* Setting 2 */}
                        <div className="flex flex-col gap-1.5">
                            <label className="text-sm font-semibold">
                                Email du support technique
                            </label>
                            <input
                                type="email"
                                value={data.support_email}
                                onChange={(e) =>
                                    setData('support_email', e.target.value)
                                }
                                placeholder="Ex: admin@moncrm.fr"
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                            />
                        </div>

                        {/* Setting 3 */}
                        <div className="flex flex-col gap-1.5">
                            <label className="text-sm font-semibold">
                                Devise par défaut
                            </label>
                            <select
                                value={data.currency}
                                onChange={(e) =>
                                    setData('currency', e.target.value)
                                }
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                            >
                                <option value="EUR">Euro (€)</option>
                                <option value="USD">Dollar ($)</option>
                                <option value="USD">
                                    Dollar Canadien ($CAD)
                                </option>
                            </select>
                        </div>
                    </div>

                    <div className="flex items-center justify-end border-t pt-4">
                        <button
                            type="submit"
                            disabled={processing}
                            className="flex items-center gap-2 rounded-md bg-primary px-6 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
                        >
                            <Save size={16} /> Enregistrer les paramètres
                        </button>
                    </div>
                </form>
            </div>
        </AppLayout>
    );
}
