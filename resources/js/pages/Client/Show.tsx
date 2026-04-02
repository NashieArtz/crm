import { Head, Link } from '@inertiajs/react';
import { Building2, Mail, Phone, Globe } from 'lucide-react';
import AppLayout from '@/layouts/app-layout';
import type { BreadcrumbItem } from '@/types';

export default function Show({ client }: { client: any }) {
    const breadcrumbs: BreadcrumbItem[] = [
        { title: 'Clients', href: '/clients' },
        { title: client.company_name, href: `/clients/${client.id_client}` },
    ];

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title={`Client - ${client.company_name}`} />

            <div className="mx-auto flex w-full max-w-7xl flex-col gap-6 p-6">
                {/* Header client */}
                <div className="flex flex-col justify-between gap-4 rounded-xl border bg-card p-6 text-card-foreground shadow-sm md:flex-row md:items-start">
                    <div className="flex items-start gap-4">
                        <div className="rounded-lg bg-primary/10 p-4 text-primary">
                            <Building2 size={32} />
                        </div>
                        <div>
                            <h1 className="text-2xl font-bold">
                                {client.company_name}
                            </h1>
                            <div className="mt-2 flex flex-wrap gap-4 text-sm text-muted-foreground">
                                {client.website && (
                                    <span className="flex items-center gap-1">
                                        <Globe size={16} /> {client.website}
                                    </span>
                                )}
                            </div>
                        </div>
                    </div>

                    {/* View primary user et backup */}
                    <div className="flex flex-col items-end gap-2">
                        <span className="text-sm font-medium text-muted-foreground">
                            Équipe assignée :
                        </span>
                        <div className="flex flex-wrap justify-end gap-2">
                            {client.users?.map((user: any) => (
                                <span
                                    key={user.id_user}
                                    className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold ${
                                        user.pivot.is_primary
                                            ? 'bg-primary text-primary-foreground'
                                            : 'bg-secondary text-secondary-foreground'
                                    }`}
                                >
                                    {user.name}{' '}
                                    {user.pivot.is_primary
                                        ? '(Titulaire)'
                                        : '(Backup)'}
                                </span>
                            ))}
                        </div>
                    </div>
                </div>

                <div className="grid grid-cols-1 gap-6 md:grid-cols-2">
                    {/* Opportunités */}
                    <div className="rounded-xl border bg-card p-6 text-card-foreground shadow-sm">
                        <h2 className="mb-4 border-b pb-2 text-lg font-bold">
                            Opportunités liées
                        </h2>
                        <ul className="space-y-3">
                            {client.opportunities?.length === 0 ? (
                                <li className="text-sm text-muted-foreground">
                                    Aucune opportunité en cours.
                                </li>
                            ) : (
                                client.opportunities?.map((opp: any) => (
                                    <li
                                        key={opp.id_opportunity}
                                        className="flex items-start justify-between rounded-lg bg-muted/30 p-4"
                                    >
                                        <div className="flex flex-col gap-1">
                                            {/* Remplacement du nom par la description comme élément principal */}
                                            <p className="mb-1 text-sm font-semibold text-foreground">
                                                {opp.details||
                                                    'Description non renseignée'}
                                            </p>

                                            {/* Détails : Source, Type, Statut, Date */}
                                            <p className="text-xs text-muted-foreground">
                                                <strong className="font-medium text-foreground/80">
                                                    Source :
                                                </strong>{' '}
                                                {opp.source || 'N/A'}
                                            </p>
                                            <p className="text-xs text-muted-foreground">
                                                <strong className="font-medium text-foreground/80">
                                                    Type :
                                                </strong>{' '}
                                                {opp.type}
                                            </p>
                                            <p className="text-xs text-muted-foreground">
                                                <strong className="font-medium text-foreground/80">
                                                    Statut :
                                                </strong>{' '}
                                                {opp.status}
                                            </p>
                                            <p className="text-xs text-muted-foreground">
                                                <strong className="font-medium text-foreground/80">
                                                    Clôturée le :
                                                </strong>{' '}
                                                {opp.closed_date
                                                    ? new Date(
                                                          opp.closed_date,
                                                      ).toLocaleDateString()
                                                    : 'En cours'}
                                            </p>
                                        </div>

                                        {/* Montant aligné à droite */}
                                        <span className="mt-1 rounded-md bg-primary/10 px-2 py-1 text-sm font-bold whitespace-nowrap text-primary">
                                            {opp.amount} €
                                        </span>
                                    </li>
                                ))
                            )}
                        </ul>
                    </div>

                    {/* Historique des Activités */}
                    <div className="rounded-xl border bg-card p-6 text-card-foreground shadow-sm">
                        <h2 className="mb-4 border-b pb-2 text-lg font-bold">
                            Historique (Activités)
                        </h2>
                        <ul className="relative space-y-4 before:absolute before:inset-0 before:ml-2 before:h-full before:w-0.5 before:-translate-x-px before:bg-gradient-to-b before:from-transparent before:via-border before:to-transparent md:before:mx-auto md:before:translate-x-0">
                            {client.activities?.length === 0 ? (
                                <li className="pl-6 text-sm text-muted-foreground">
                                    Aucune activité enregistrée.
                                </li>
                            ) : (
                                client.activities?.map((activity: any) => (
                                    <li
                                        key={activity.id_activity}
                                        className="relative pl-6 md:pl-0"
                                    >
                                        <div className="items-center justify-between md:flex">
                                            <div className="mb-1 md:mb-0 md:w-1/2">
                                                <span className="rounded-full border bg-background px-2 py-1 text-xs text-muted-foreground">
                                                    {new Date(
                                                        activity.date_activity,
                                                    ).toLocaleDateString()}
                                                </span>
                                            </div>
                                            <div className="ml-4 w-full rounded-lg border bg-muted/50 p-3 md:w-1/2">
                                                <p className="mb-1 text-xs font-semibold text-primary uppercase">
                                                    {activity.type}
                                                </p>
                                                <p className="text-sm">
                                                    {activity.description}
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                ))
                            )}
                        </ul>
                    </div>
                </div>
            </div>
        </AppLayout>
    );
}
