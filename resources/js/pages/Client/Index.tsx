import { Head, Link, router } from '@inertiajs/react';
import {
    Building2,
    Globe,
    ArrowRight,
    Briefcase,
    Plus,
    Search,
    Users,
} from 'lucide-react';
import { useState, useEffect, useRef } from 'react';
import { ClientForm } from '@/components/client-form';
import AppLayout from '@/layouts/app-layout';
import type { BreadcrumbItem } from '@/types';

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Dashboard', href: '/dashboard' },
    { title: 'Clients', href: '/clients' },
];

export default function Index({
    clients,
    filters,
}: {
    clients: any[];
    filters: any;
}) {
    const { auth } = usePage<any>().props;
    const isAdmin = auth.user?.is_admin || false;

    // recherche reste écrite dans input (filters?.search)
    const [searchTerm, setSearchTerm] = useState(filters?.search || '');
    const [showClientForm, setShowClientForm] = useState(false);

    // Exec func dès que searchTerm change
    useEffect(() => {
        // Anti-rebond, éviter 50 requêtes en 1 secondes
        const delaySearch = setTimeout(() => {
            // Requête silencieuse (AJAX)
            router.get(
                '/clients',
                // Send term au controller
                { search: searchTerm },
                {
                    // Garde les états
                    preserveState: true,
                    // Empêche la page de remonter tout en haut
                    preserveScroll: true,
                    // No new historique
                    replace: true,
                },
            );
        }, 300);

        // destroy timer
        return () => clearTimeout(delaySearch);
    }, [searchTerm]);

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Liste des Clients" />

            <div className="mx-auto w-full max-w-7xl p-6">
                <div className="mb-8 flex flex-col gap-4 border-b pb-4 sm:flex-row sm:items-center sm:justify-between">
                    <div>
                        <h1 className="text-3xl font-bold tracking-tight">
                            Mon Portefeuille
                        </h1>
                        <p className="mt-1 text-sm text-muted-foreground">
                            Gérez vos relations clients et suivez vos
                            opportunités en cours.
                        </p>
                    </div>

                    {/* Bouton Nouveau Client */}
                    <button
                        type="button"
                        onClick={() => setShowClientForm(!showClientForm)}
                        className="inline-flex h-10 items-center justify-center gap-2 rounded-md bg-primary px-4 py-2 text-sm font-medium whitespace-nowrap text-primary-foreground shadow transition-colors hover:bg-primary/90 focus-visible:ring-1 focus-visible:ring-ring focus-visible:outline-none"
                    >
                        <Plus size={16} />
                        Nouveau Client
                    </button>
                </div>

                {/* Affichage conditionnel du formulaire Client */}
                {showClientForm && (
                    <ClientForm onSuccess={() => setShowClientForm(false)} />
                )}

                {/* Barre de recherche */}
                <div className="mb-6 flex items-center">
                    <div className="relative w-full max-w-sm">
                        <Search className="absolute top-1/2 left-3 size-4 -translate-y-1/2 text-muted-foreground" />
                        <input
                            type="text"
                            placeholder="Rechercher une entreprise ou un site web..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            className="flex h-10 w-full rounded-md border border-input bg-background py-2 pr-4 pl-10 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 focus-visible:outline-none disabled:cursor-not-allowed disabled:opacity-50"
                        />
                    </div>
                </div>

                {clients.length === 0 ? (
                    <div className="flex flex-col items-center justify-center rounded-xl border border-dashed p-12 text-center">
                        <Building2 className="mb-4 size-12 text-muted-foreground/50" />
                        <h3 className="text-lg font-semibold">
                            Aucun client trouvé
                        </h3>
                        <p className="text-sm text-muted-foreground">
                            Vous n'avez pas encore de clients assignés à votre
                            portefeuille.
                        </p>
                    </div>
                ) : (
                    /* Grille */
                    <div className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
                        {clients.map((client) => (
                            <div
                                key={client.id_client}
                                className="group relative flex flex-col justify-between overflow-hidden rounded-xl border bg-card text-card-foreground shadow-sm transition-all hover:-translate-y-1 hover:shadow-md dark:hover:border-primary/50"
                            >
                                {/* Carte client */}
                                <div className="p-6">
                                    <div className="mb-4 flex items-center gap-3">
                                        <div className="flex size-10 items-center justify-center rounded-lg bg-primary/10 text-primary">
                                            <Building2 size={20} />
                                        </div>
                                        <h2
                                            className="line-clamp-1 text-lg font-bold"
                                            title={client.company_name}
                                        >
                                            {client.company_name}
                                        </h2>
                                    </div>

                                    {/* Détails */}
                                    <div className="space-y-3 text-sm">
                                        {client.website ? (
                                            <a
                                                href={client.website}
                                                target="_blank"
                                                rel="noreferrer"
                                                className="flex items-center gap-2 text-muted-foreground transition-colors hover:text-blue-500"
                                                onClick={(e) =>
                                                    e.stopPropagation()
                                                }
                                            >
                                                <Globe size={16} />
                                                <span className="line-clamp-1 truncate">
                                                    {client.website}
                                                </span>
                                            </a>
                                        ) : (
                                            <div className="flex items-center gap-2 text-muted-foreground/50">
                                                <Globe size={16} />
                                                <span>Aucun site web</span>
                                            </div>
                                        )}

                                        <div className="flex items-center gap-2 text-muted-foreground">
                                            <Briefcase size={16} />
                                            <span>
                                                <strong className="font-medium text-foreground">
                                                    {client.opportunities
                                                        ?.length || 0}
                                                </strong>{' '}
                                                opportunité(s)
                                            </span>
                                        </div>
                                    </div>

                                    {/* affichage admin */}
                                    {isAdmin &&
                                        client.users &&
                                        client.users.length > 0 && (
                                            <div className="mt-4 border-t pt-4">
                                                <div className="mb-2 flex items-center gap-2 text-xs font-semibold text-muted-foreground">
                                                    <Users size={14} /> Équipe
                                                    assignée
                                                </div>
                                                <div className="flex flex-wrap gap-1.5">
                                                    {client.users.map(
                                                        (user: any) => (
                                                            <span
                                                                key={
                                                                    user.id_user
                                                                }
                                                                className={`inline-flex items-center rounded-md px-2 py-0.5 text-[11px] font-medium ${
                                                                    user.pivot
                                                                        .is_primary
                                                                        ? 'bg-primary/10 text-primary dark:bg-primary/20'
                                                                        : 'bg-secondary text-secondary-foreground'
                                                                }`}
                                                                title={
                                                                    user.pivot
                                                                        .is_primary
                                                                        ? 'Titulaire du compte'
                                                                        : 'Remplaçant / Soutien'
                                                                }
                                                            >
                                                                {user.name}{' '}
                                                                {user.pivot
                                                                    .is_primary
                                                                    ? '(T)'
                                                                    : '(B)'}
                                                            </span>
                                                        ),
                                                    )}
                                                </div>
                                            </div>
                                        )}
                                </div>

                                {/* Lien */}
                                <div className="border-t bg-muted/20 p-4">
                                    <Link
                                        href={`/clients/${client.id_client}`}
                                        className="flex w-full items-center justify-center gap-2 rounded-md bg-secondary px-4 py-2 text-sm font-medium text-secondary-foreground transition-colors group-hover:bg-primary group-hover:text-primary-foreground hover:bg-primary hover:text-primary-foreground"
                                    >
                                        Voir le dossier
                                        <ArrowRight
                                            size={16}
                                            className="transition-transform group-hover:translate-x-1"
                                        />
                                    </Link>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </AppLayout>
    );
}
