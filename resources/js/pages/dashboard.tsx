import { Head, Link } from '@inertiajs/react';
import { Users } from 'lucide-react';
import { CardDashboard } from '@/components/card-dashboard';
import { ChartDashboard } from '@/components/chart-dashboard';
import { TableDashboard } from '@/components/table-dashboard';
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
    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Dashboard" />
            <div className="flex flex-col gap-4 p-4">
                {/* Top row — 3 equal cards */}
                <div className="grid grid-cols-1 gap-4 md:grid-cols-3">
                    {/* Client card */}
                    <div className="flex flex-col items-center justify-center rounded-xl border border-sidebar-border/70 bg-card p-6 text-card-foreground shadow-sm dark:border-sidebar-border">
                        <Users className="mb-4 size-10 text-primary" />
                        <h3 className="mb-2 text-lg font-bold">
                            Gestion des Clients
                        </h3>
                        <p className="mb-4 text-center text-sm text-muted-foreground">
                            Gérez votre portefeuille, ajoutez des remplaçants et
                            suivez vos opportunités.
                        </p>
                        <Link
                            href="/clients"
                            className="inline-flex h-10 items-center justify-center rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground transition-colors hover:bg-primary/90 focus-visible:ring-2 focus-visible:ring-ring focus-visible:outline-none"
                        >
                            Voir la liste des clients
                        </Link>
                    </div>

                    {/* Chart card */}
                    <div className="rounded-xl border border-sidebar-border/70 bg-card shadow-sm dark:border-sidebar-border">
                        <ChartDashboard
                            title="Revenu total par mois"
                            description="Évolution du revenu sur les 12 derniers mois"
                            chartData={data.incomeData.monthlyIncome}
                            xAxis="month"
                            yAxis="total"
                        />
                    </div>

                    {/* Opportunities card */}
                    <div className="rounded-xl border border-sidebar-border/70 bg-card shadow-sm dark:border-sidebar-border">
                        <CardDashboard
                            title="Opportunités totales"
                            data={data.totalOpportunities}
                            description="asdsadf"
                        />
                    </div>
                </div>

                {/* Table with scrollbar */}
                <div className="overflow-auto rounded-xl border border-sidebar-border/70 bg-card shadow-sm dark:border-sidebar-border">
                    <div className="max-h-[400px] overflow-y-auto">
                        <TableDashboard tabledata={data.latestOpportunities} />
                    </div>
                </div>
            </div>
        </AppLayout>
    );
}
