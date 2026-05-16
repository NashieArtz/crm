import { Head, Link } from '@inertiajs/react';
import {
    ArrowDownRight,
    ArrowUpRight,
    Building2,
    CircleDollarSign,
    Flame,
    LayoutGrid,
    Target,
    TrendingUp,
    Trophy,
    Zap,
} from 'lucide-react';
import {
    Area,
    AreaChart,
    Bar,
    BarChart,
    CartesianGrid,
    Cell,
    Legend,
    Pie,
    PieChart,
    RadialBar,
    RadialBarChart,
    ResponsiveContainer,
    Tooltip,
    XAxis,
    YAxis,
} from 'recharts';
import { Badge } from '@/components/ui/badge';
import AppLayout from '@/layouts/app-layout';
import { dashboard } from '@/routes';
import type { BreadcrumbItem } from '@/types';

interface Opportunity {
    id_opportunity: number;
    title?: string;
    status: string;
    type: string;
    amount: string | number;
    updated_at: string;
    client?: { id_client: number; company_name: string };
}

interface Activity {
    id_activity?: number;
    type?: string;
    description?: string;
    created_at?: string;
    clients?: { id_client: number; company_name: string }[];
}

interface DashboardProps {
    stats: {
        total_clients: number;
        active_opportunities: number;
        total_revenue: number;
        conversion_rate: number;
    };
    salesData: { month: string; amount: number; total: number }[];
    opportunityStats: { name: string; value: number; total: number }[];
    incomeData: {
        monthlyIncome: { month: string; amount: number; total: number }[];
        weeklyIncome: { label: string; income: number }[];
    };
    totalClient: number;
    totalOpportunities: number;
    opportunityPotentialIncome: number;
    opportunityTotalIncome: number;
    opportunityPotentialTotalIncome: number;
    incomePerDayPerWeek: { day: string; amount: number }[];
    incomePerDayPerMonth: { day: string; amount: number }[];
    latestOpportunities: Opportunity[];
    latestOpportunitiesByOption: Opportunity[];
    latestActivitiesData: Activity[];
    oppBySegments: { name: string; value: number; total: number }[];
    topAccounts: { company: string; revenue: number }[];
}

const fmt = (n: number) =>
    new Intl.NumberFormat('fr-FR', {
        style: 'currency',
        currency: 'EUR',
        maximumFractionDigits: 0,
    }).format(n);

const fmtShort = (n: number) => {
    if (n >= 1_000_000) return `${(n / 1_000_000).toFixed(1)}M €`;
    if (n >= 1_000) return `${(n / 1_000).toFixed(0)}k €`;
    return `${n} €`;
};

const STATUS_META: Record<
    string,
    { label: string; color: string; bg: string }
> = {
    qualification: {
        label: 'Qualification',
        color: 'text-blue-700 dark:text-blue-300',
        bg: 'bg-blue-100 dark:bg-blue-900/40',
    },
    proposal: {
        label: 'Proposition',
        color: 'text-violet-700 dark:text-violet-300',
        bg: 'bg-violet-100 dark:bg-violet-900/40',
    },
    negotiation: {
        label: 'Négociation',
        color: 'text-amber-700 dark:text-amber-300',
        bg: 'bg-amber-100 dark:bg-amber-900/40',
    },
    closed_won: {
        label: 'Gagné',
        color: 'text-emerald-700 dark:text-emerald-300',
        bg: 'bg-emerald-100 dark:bg-emerald-900/40',
    },
    closed_lost: {
        label: 'Perdu',
        color: 'text-red-700 dark:text-red-300',
        bg: 'bg-red-100 dark:bg-red-900/40',
    },
};

const TYPE_META: Record<string, string> = {
    renewal: 'Renouvellement',
    new_business: 'Nouveau client',
    upsell: 'Upsell',
};

const PIE_COLORS = [
    'var(--color-chart-1, #3b82f6)',
    'var(--color-chart-2, #8b5cf6)',
    'var(--color-chart-3, #10b981)',
    'var(--color-chart-4, #f59e0b)',
    'var(--color-chart-5, #ef4444)',
];

function KpiCard({
    label,
    value,
    sub,
    icon: Icon,
    trend,
    accent,
}: {
    label: string;
    value: string;
    sub: string;
    icon: React.ElementType;
    trend?: 'up' | 'down' | 'neutral';
    accent: string;
}) {
    return (
        <div className="group relative overflow-hidden rounded-2xl border border-border/60 bg-card p-6 shadow-sm transition-all hover:shadow-md">
            {/* accent stripe */}
            <div
                className={`absolute inset-y-0 left-0 w-1 ${accent} rounded-l-2xl`}
            />
            <div className="flex items-start justify-between">
                <div className="space-y-1 pl-2">
                    <p className="text-xs font-semibold tracking-widest text-muted-foreground uppercase">
                        {label}
                    </p>
                    <p className="text-3xl font-bold text-foreground tabular-nums">
                        {value}
                    </p>
                    <p className="flex items-center gap-1 text-xs text-muted-foreground">
                        {trend === 'up' && (
                            <ArrowUpRight className="h-3 w-3 text-emerald-500" />
                        )}
                        {trend === 'down' && (
                            <ArrowDownRight className="h-3 w-3 text-red-500" />
                        )}
                        {sub}
                    </p>
                </div>
                <div
                    className={`flex h-11 w-11 items-center justify-center rounded-xl ${accent} bg-opacity-15`}
                >
                    <Icon className="h-5 w-5 text-foreground/70" />
                </div>
            </div>
        </div>
    );
}

function SectionTitle({
    icon: Icon,
    title,
    sub,
}: {
    icon: React.ElementType;
    title: string;
    sub?: string;
}) {
    return (
        <div className="flex items-center gap-3">
            <div className="flex h-8 w-8 items-center justify-center rounded-lg bg-primary/10">
                <Icon className="h-4 w-4 text-primary" />
            </div>
            <div>
                <h2 className="text-sm font-bold text-foreground">{title}</h2>
                {sub && <p className="text-xs text-muted-foreground">{sub}</p>}
            </div>
        </div>
    );
}

function StatusBadge({ status }: { status: string }) {
    const meta = STATUS_META[status] ?? {
        label: status,
        color: 'text-foreground',
        bg: 'bg-muted',
    };
    return (
        <span
            className={`inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold ${meta.bg} ${meta.color}`}
        >
            {meta.label}
        </span>
    );
}

function ChartTooltip({
    active,
    payload,
    label,
    currency = true,
}: {
    active?: boolean;
    payload?: any[];
    label?: string;
    currency?: boolean;
}) {
    if (!active || !payload?.length) return null;
    return (
        <div className="rounded-xl border border-border bg-card px-3 py-2 shadow-lg">
            {label && (
                <p className="mb-1 text-xs font-semibold text-muted-foreground">
                    {label}
                </p>
            )}
            {payload.map((p: any, i: number) => (
                <p key={i} className="text-sm font-bold text-foreground">
                    {currency ? fmtShort(p.value) : p.value}
                </p>
            ))}
        </div>
    );
}

const breadcrumbs: BreadcrumbItem[] = [
    { title: 'Dashboard', href: dashboard() },
];

export default function Dashboard(data: DashboardProps) {
    const {
        stats,
        incomeData,
        incomePerDayPerWeek,
        incomePerDayPerMonth,
        totalOpportunities,
        opportunityTotalIncome,
        opportunityPotentialIncome,
        opportunityPotentialTotalIncome,
        latestOpportunities,
        latestActivitiesData,
        oppBySegments,
        topAccounts,
    } = data;

    const pipelineCounts = latestOpportunities.reduce(
        (acc: Record<string, number>, opp) => {
            acc[opp.status] = (acc[opp.status] || 0) + 1;
            return acc;
        },
        {},
    );

    const funnelData = [
        'qualification',
        'proposal',
        'negotiation',
        'closed_won',
        'closed_lost',
    ].map((s) => ({
        name: STATUS_META[s]?.label ?? s,
        count: pipelineCounts[s] ?? 0,
    }));

    const gaugePercent =
        opportunityPotentialTotalIncome > 0
            ? Math.round(
                  (opportunityTotalIncome / opportunityPotentialTotalIncome) *
                      100,
              )
            : 0;

    const radialData = [
        {
            name: 'Réalisé',
            value: gaugePercent,
            fill: 'var(--color-chart-3, #10b981)',
        },
    ];

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Dashboard" />

            <div className="flex flex-col gap-6 p-4 md:p-6">
                {/* Header */}
                <div className="flex flex-col gap-1">
                    <h1 className="text-2xl font-bold tracking-tight text-foreground">
                        Vue d'ensemble
                    </h1>
                    <p className="text-sm text-muted-foreground">
                        Pilotez votre activité commerciale en temps réel.
                    </p>
                </div>

                {/* KPI */}
                <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
                    <KpiCard
                        label="Clients"
                        value={String(stats.total_clients)}
                        sub="portefeuille actif"
                        icon={Building2}
                        trend="up"
                        accent="bg-blue-500"
                    />
                    <KpiCard
                        label="Opportunités actives"
                        value={String(stats.active_opportunities)}
                        sub={`sur ${totalOpportunities} total`}
                        icon={Zap}
                        trend="neutral"
                        accent="bg-violet-500"
                    />
                    <KpiCard
                        label="Chiffre d'affaires"
                        value={fmtShort(opportunityTotalIncome)}
                        sub="opportunités gagnées"
                        icon={CircleDollarSign}
                        trend="up"
                        accent="bg-emerald-500"
                    />
                    <KpiCard
                        label="Taux de conversion"
                        value={`${stats.conversion_rate}%`}
                        sub="clients → opportunités gagnées"
                        icon={Target}
                        trend={stats.conversion_rate > 20 ? 'up' : 'down'}
                        accent="bg-amber-500"
                    />
                </div>

                {/* revenue total */}
                <div className="relative overflow-hidden rounded-2xl border border-border/60 bg-gradient-to-r from-primary/10 via-primary/5 to-transparent p-5">
                    <div className="flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
                        <div className="flex items-center gap-4">
                            <div className="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/20">
                                <Flame className="h-6 w-6 text-primary" />
                            </div>
                            <div>
                                <p className="text-xs font-semibold tracking-widest text-muted-foreground uppercase">
                                    Pipeline total (gagné + potentiel)
                                </p>
                                <p className="text-2xl font-bold text-foreground">
                                    {fmt(opportunityPotentialTotalIncome)}
                                </p>
                            </div>
                        </div>
                        <div className="flex gap-6">
                            <div className="text-center">
                                <p className="text-xs text-muted-foreground">
                                    Gagné
                                </p>
                                <p className="text-lg font-bold text-emerald-600 dark:text-emerald-400">
                                    {fmt(opportunityTotalIncome)}
                                </p>
                            </div>
                            <div className="text-center">
                                <p className="text-xs text-muted-foreground">
                                    En cours
                                </p>
                                <p className="text-lg font-bold text-amber-600 dark:text-amber-400">
                                    {fmt(opportunityPotentialIncome)}
                                </p>
                            </div>
                            <div className="text-center">
                                <p className="text-xs text-muted-foreground">
                                    Réalisé
                                </p>
                                <p className="text-lg font-bold text-primary">
                                    {gaugePercent}%
                                </p>
                            </div>
                        </div>
                    </div>
                    {/* progress bar */}
                    <div className="mt-4 h-1.5 w-full overflow-hidden rounded-full bg-border/60">
                        <div
                            className="h-full rounded-full bg-emerald-500 transition-all duration-700"
                            style={{ width: `${gaugePercent}%` }}
                        />
                    </div>
                </div>

                {/*  Charts */}
                <div className="grid grid-cols-1 gap-4 lg:grid-cols-3">
                    {/* Revenu cumulé 12 mois */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm lg:col-span-2">
                        <div className="mb-4 flex items-center justify-between">
                            <SectionTitle
                                icon={TrendingUp}
                                title="Revenu cumulé"
                                sub="12 derniers mois"
                            />
                            <span className="text-xs text-muted-foreground">
                                Cumul total
                            </span>
                        </div>
                        <ResponsiveContainer width="100%" height={220}>
                            <AreaChart
                                data={incomeData.monthlyIncome}
                                margin={{
                                    left: 0,
                                    right: 0,
                                    top: 4,
                                    bottom: 0,
                                }}
                            >
                                <defs>
                                    <linearGradient
                                        id="grad-revenue"
                                        x1="0"
                                        y1="0"
                                        x2="0"
                                        y2="1"
                                    >
                                        <stop
                                            offset="5%"
                                            stopColor="var(--color-chart-3, #10b981)"
                                            stopOpacity={0.25}
                                        />
                                        <stop
                                            offset="95%"
                                            stopColor="var(--color-chart-3, #10b981)"
                                            stopOpacity={0}
                                        />
                                    </linearGradient>
                                </defs>
                                <CartesianGrid
                                    strokeDasharray="3 3"
                                    stroke="var(--border)"
                                    vertical={false}
                                />
                                <XAxis
                                    dataKey="month"
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                    tickFormatter={(v) => v.slice(0, 3)}
                                />
                                <YAxis
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                    tickFormatter={fmtShort}
                                    width={56}
                                />
                                <Tooltip content={<ChartTooltip />} />
                                <Area
                                    type="monotone"
                                    dataKey="total"
                                    stroke="var(--color-chart-3, #10b981)"
                                    strokeWidth={2.5}
                                    fill="url(#grad-revenue)"
                                    dot={false}
                                    activeDot={{ r: 4 }}
                                />
                            </AreaChart>
                        </ResponsiveContainer>
                    </div>

                    {/* Répartition par segment (Pie) */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm">
                        <div className="mb-4">
                            <SectionTitle
                                icon={LayoutGrid}
                                title="Segments (CA gagné)"
                                sub="Par type d'opportunité"
                            />
                        </div>
                        {oppBySegments.length === 0 ? (
                            <div className="flex h-[220px] items-center justify-center text-sm text-muted-foreground">
                                Aucune donnée
                            </div>
                        ) : (
                            <div className="flex flex-col items-center gap-3">
                                <ResponsiveContainer width="100%" height={170}>
                                    <PieChart>
                                        <Pie
                                            data={oppBySegments}
                                            dataKey="value"
                                            nameKey="name"
                                            cx="50%"
                                            cy="50%"
                                            innerRadius={50}
                                            outerRadius={75}
                                            paddingAngle={3}
                                        >
                                            {oppBySegments.map((_, i) => (
                                                <Cell
                                                    key={i}
                                                    fill={
                                                        PIE_COLORS[
                                                            i %
                                                                PIE_COLORS.length
                                                        ]
                                                    }
                                                />
                                            ))}
                                        </Pie>
                                        <Tooltip
                                            formatter={(v: number) =>
                                                fmtShort(v)
                                            }
                                        />
                                    </PieChart>
                                </ResponsiveContainer>
                                <div className="flex flex-wrap justify-center gap-2">
                                    {oppBySegments.map((seg, i) => (
                                        <span
                                            key={i}
                                            className="flex items-center gap-1.5 text-xs text-muted-foreground"
                                        >
                                            <span
                                                className="inline-block h-2 w-2 rounded-full"
                                                style={{
                                                    background:
                                                        PIE_COLORS[
                                                            i %
                                                                PIE_COLORS.length
                                                        ],
                                                }}
                                            />
                                            {seg.name}
                                        </span>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                </div>

                {/*  Charts 2 */}
                <div className="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
                    {/* Revenu par jour (semaine) */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm">
                        <div className="mb-4">
                            <SectionTitle
                                icon={Zap}
                                title="Revenu / jour"
                                sub="7 derniers jours"
                            />
                        </div>
                        <ResponsiveContainer width="100%" height={180}>
                            <BarChart
                                data={incomePerDayPerWeek}
                                margin={{
                                    left: 0,
                                    right: 0,
                                    top: 4,
                                    bottom: 0,
                                }}
                            >
                                <CartesianGrid
                                    strokeDasharray="3 3"
                                    stroke="var(--border)"
                                    vertical={false}
                                />
                                <XAxis
                                    dataKey="day"
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                />
                                <YAxis
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                    tickFormatter={fmtShort}
                                    width={52}
                                />
                                <Tooltip content={<ChartTooltip />} />
                                <Bar
                                    dataKey="amount"
                                    fill="var(--color-chart-1, #3b82f6)"
                                    radius={[4, 4, 0, 0]}
                                />
                            </BarChart>
                        </ResponsiveContainer>
                    </div>

                    {/* Revenu par jour (30 jours) */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm">
                        <div className="mb-4">
                            <SectionTitle
                                icon={CircleDollarSign}
                                title="Revenu / jour"
                                sub="30 derniers jours"
                            />
                        </div>
                        <ResponsiveContainer width="100%" height={180}>
                            <AreaChart
                                data={incomePerDayPerMonth}
                                margin={{
                                    left: 0,
                                    right: 0,
                                    top: 4,
                                    bottom: 0,
                                }}
                            >
                                <defs>
                                    <linearGradient
                                        id="grad-daily"
                                        x1="0"
                                        y1="0"
                                        x2="0"
                                        y2="1"
                                    >
                                        <stop
                                            offset="5%"
                                            stopColor="var(--color-chart-1, #3b82f6)"
                                            stopOpacity={0.25}
                                        />
                                        <stop
                                            offset="95%"
                                            stopColor="var(--color-chart-1, #3b82f6)"
                                            stopOpacity={0}
                                        />
                                    </linearGradient>
                                </defs>
                                <CartesianGrid
                                    strokeDasharray="3 3"
                                    stroke="var(--border)"
                                    vertical={false}
                                />
                                <XAxis
                                    dataKey="day"
                                    tick={{
                                        fontSize: 9,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                    interval={4}
                                />
                                <YAxis
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                    tickFormatter={fmtShort}
                                    width={52}
                                />
                                <Tooltip content={<ChartTooltip />} />
                                <Area
                                    type="monotone"
                                    dataKey="amount"
                                    stroke="var(--color-chart-1, #3b82f6)"
                                    strokeWidth={2}
                                    fill="url(#grad-daily)"
                                    dot={false}
                                />
                            </AreaChart>
                        </ResponsiveContainer>
                    </div>

                    {/* pipeline */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm">
                        <div className="mb-4">
                            <SectionTitle
                                icon={Target}
                                title="Pipeline"
                                sub="Répartition par statut"
                            />
                        </div>
                        <ResponsiveContainer width="100%" height={180}>
                            <BarChart
                                layout="vertical"
                                data={funnelData}
                                margin={{
                                    left: 4,
                                    right: 8,
                                    top: 0,
                                    bottom: 0,
                                }}
                            >
                                <XAxis
                                    type="number"
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                />
                                <YAxis
                                    type="category"
                                    dataKey="name"
                                    tick={{
                                        fontSize: 10,
                                        fill: 'var(--muted-foreground)',
                                    }}
                                    tickLine={false}
                                    axisLine={false}
                                    width={76}
                                />
                                <Tooltip
                                    content={<ChartTooltip currency={false} />}
                                />
                                <Bar dataKey="count" radius={[0, 4, 4, 0]}>
                                    {funnelData.map((_, i) => (
                                        <Cell
                                            key={i}
                                            fill={
                                                PIE_COLORS[
                                                    i % PIE_COLORS.length
                                                ]
                                            }
                                        />
                                    ))}
                                </Bar>
                            </BarChart>
                        </ResponsiveContainer>
                    </div>
                </div>

                <div className="grid grid-cols-1 gap-4 lg:grid-cols-3">
                    {/* Top clients */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm">
                        <div className="mb-4">
                            <SectionTitle
                                icon={Trophy}
                                title="Top 5 clients"
                                sub="CA généré (opportunités gagnées)"
                            />
                        </div>
                        {topAccounts.length === 0 ? (
                            <p className="py-8 text-center text-sm text-muted-foreground">
                                Aucune donnée
                            </p>
                        ) : (
                            <div className="space-y-3">
                                {topAccounts.map((acc, i) => {
                                    const maxRevenue =
                                        topAccounts[0]?.revenue || 1;
                                    const pct = Math.round(
                                        (acc.revenue / maxRevenue) * 100,
                                    );
                                    return (
                                        <div key={i} className="space-y-1">
                                            <div className="flex items-center justify-between text-sm">
                                                <span className="flex items-center gap-2 font-medium text-foreground">
                                                    <span className="flex h-5 w-5 items-center justify-center rounded-full bg-muted text-[10px] font-bold text-muted-foreground">
                                                        {i + 1}
                                                    </span>
                                                    {acc.company}
                                                </span>
                                                <span className="font-semibold text-foreground">
                                                    {fmtShort(acc.revenue)}
                                                </span>
                                            </div>
                                            <div className="h-1.5 w-full overflow-hidden rounded-full bg-muted">
                                                <div
                                                    className="h-full rounded-full bg-primary transition-all duration-500"
                                                    style={{ width: `${pct}%` }}
                                                />
                                            </div>
                                        </div>
                                    );
                                })}
                            </div>
                        )}
                    </div>

                    {/* Dernières opportunités */}
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm lg:col-span-2">
                        <div className="mb-4 flex items-center justify-between">
                            <SectionTitle
                                icon={Flame}
                                title="Dernières opportunités"
                                sub="10 plus récentes"
                            />
                            <Link
                                href="/clients"
                                className="text-xs font-medium text-primary hover:underline"
                            >
                                Voir tout →
                            </Link>
                        </div>
                        <div className="overflow-x-auto">
                            <table className="w-full text-sm">
                                <thead>
                                    <tr className="border-b border-border/60">
                                        <th className="pb-2 text-left text-xs font-semibold tracking-wider text-muted-foreground uppercase">
                                            Client
                                        </th>
                                        <th className="pb-2 text-left text-xs font-semibold tracking-wider text-muted-foreground uppercase">
                                            Type
                                        </th>
                                        <th className="pb-2 text-left text-xs font-semibold tracking-wider text-muted-foreground uppercase">
                                            Statut
                                        </th>
                                        <th className="pb-2 text-right text-xs font-semibold tracking-wider text-muted-foreground uppercase">
                                            Montant
                                        </th>
                                    </tr>
                                </thead>
                                <tbody className="divide-y divide-border/40">
                                    {latestOpportunities
                                        .slice(0, 8)
                                        .map((opp) => (
                                            <tr
                                                key={opp.id_opportunity}
                                                className="group transition-colors hover:bg-muted/30"
                                            >
                                                <td className="py-2.5 pr-4 font-medium text-foreground">
                                                    {opp.client?.company_name ??
                                                        '—'}
                                                </td>
                                                <td className="py-2.5 pr-4 text-muted-foreground">
                                                    {TYPE_META[opp.type] ??
                                                        opp.type}
                                                </td>
                                                <td className="py-2.5 pr-4">
                                                    <StatusBadge
                                                        status={opp.status}
                                                    />
                                                </td>
                                                <td className="py-2.5 text-right font-semibold text-foreground tabular-nums">
                                                    {fmt(Number(opp.amount))}
                                                </td>
                                            </tr>
                                        ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                {/* ── Recent activities ──────────────────────────── */}
                {latestActivitiesData.length > 0 && (
                    <div className="rounded-2xl border border-border/60 bg-card p-5 shadow-sm">
                        <div className="mb-4">
                            <SectionTitle
                                icon={Zap}
                                title="Activités récentes"
                                sub="10 dernières actions"
                            />
                        </div>
                        <div className="grid grid-cols-1 gap-2 sm:grid-cols-2 lg:grid-cols-5">
                            {latestActivitiesData.slice(0, 10).map((act, i) => (
                                <div
                                    key={i}
                                    className="flex flex-col gap-1 rounded-xl border border-border/50 bg-muted/30 p-3 text-sm"
                                >
                                    <span className="flex items-center gap-1.5">
                                        <span className="h-1.5 w-1.5 rounded-full bg-primary" />
                                        <span className="text-xs font-semibold tracking-wide text-muted-foreground uppercase">
                                            {act.type ?? 'Activité'}
                                        </span>
                                    </span>
                                    <p className="line-clamp-2 text-xs text-foreground">
                                        {act.description ?? '—'}
                                    </p>
                                    {act.clients?.[0] && (
                                        <p className="text-[10px] font-medium text-primary/80">
                                            {act.clients[0].company_name}
                                        </p>
                                    )}
                                    {act.created_at && (
                                        <p className="text-[10px] text-muted-foreground">
                                            {new Date(
                                                act.created_at,
                                            ).toLocaleDateString('fr-FR')}
                                        </p>
                                    )}
                                </div>
                            ))}
                        </div>
                    </div>
                )}
            </div>
        </AppLayout>
    );
}
