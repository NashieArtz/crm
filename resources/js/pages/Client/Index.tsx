import { Head, Link } from '@inertiajs/react';
import AppLayout from '@/layouts/app-layout';
import type { BreadcrumbItem } from '@/types';
// Ajout de l'icône Plus
import { Building2, Globe, ArrowRight, Briefcase, Plus } from 'lucide-react';

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Dashboard', href: '/dashboard' },
    { title: 'Clients', href: '/clients' },
];

export default function Index({ clients }: { clients: any[] }) {
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
                        className="inline-flex h-10 items-center justify-center gap-2 rounded-md bg-primary px-4 py-2 text-sm font-medium whitespace-nowrap text-primary-foreground shadow transition-colors hover:bg-primary/90 focus-visible:ring-1 focus-visible:ring-ring focus-visible:outline-none"
                    >
                        <Plus size={16} />
                        Nouveau Client
                    </button>
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
