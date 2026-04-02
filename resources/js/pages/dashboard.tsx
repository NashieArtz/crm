import { Head, Link } from '@inertiajs/react';
import { Users } from 'lucide-react';
import { ChartDashboard } from '@/components/chart-dashboard';
import { PlaceholderPattern } from '@/components/ui/placeholder-pattern';
import AppLayout from '@/layouts/app-layout';
import { dashboard } from '@/routes';
import type { BreadcrumbItem } from '@/types';
const breadcrumbs: BreadcrumbItem[] = [
    {
        title: 'Dashboard',
        href: dashboard(),
    },
];

export default function Dashboard(data: any) {
    console.log(data);

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Dashboard" />
            <div className="flex h-full flex-1 flex-col gap-4 overflow-x-auto rounded-xl p-4">
                <div className="grid auto-rows-min gap-4 md:grid-cols-3">

                    {/* Client */}
                    <div className="relative aspect-video overflow-hidden rounded-xl border border-sidebar-border/70 dark:border-sidebar-border">
                        <div className="relative flex aspect-video flex-col items-center justify-center overflow-hidden rounded-xl border border-sidebar-border/70 bg-card p-6 text-card-foreground shadow-sm dark:border-sidebar-border">
                            <Users className="mb-4 size-10 text-primary" />
                            <h3 className="mb-2 text-lg font-bold">
                                Gestion des Clients
                            </h3>
                            <p className="mb-4 text-center text-sm text-muted-foreground">
                                Gérez votre portefeuille, ajoutez des
                                remplaçants et suivez vos opportunités.
                            </p>

                            <Link
                                href="/clients"
                                className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground transition-colors hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring focus-visible:outline-none"
                            >
                                Voir la liste des clients
                            </Link>
                        </div>
                    </div>


                    <div className="relative aspect-video overflow-visible rounded-xl border border-sidebar-border/70 dark:border-sidebar-border">
                        <ChartDashboard
                            title="Revenu total par mois"
                            description="Évolution du revenu sur les 12 derniers mois"
                            chartData={data.incomeData.monthlyIncome}
                            xAxis="month"
                            yAxis="total"
                        />
                    </div>
                    <div className="relative aspect-video overflow-hidden rounded-xl border border-sidebar-border/70 dark:border-sidebar-border">
                        <PlaceholderPattern className="absolute inset-0 size-full stroke-neutral-900/20 dark:stroke-neutral-100/20" />
                    </div>
                </div>

                <div className="relative min-h-[100vh] flex-1 overflow-hidden rounded-xl border border-sidebar-border/70 md:min-h-min dark:border-sidebar-border">
                    <PlaceholderPattern className="absolute inset-0 size-full stroke-neutral-900/20 dark:stroke-neutral-100/20" />
                </div>
            </div>
        </AppLayout>
    );
}
