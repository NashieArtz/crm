import { Link, usePage } from '@inertiajs/react';
import {
    Activity,
    BarChart3,
    Building2,
    LayoutGrid,
    Settings,
    ShieldCheck,
    Users,
    Zap,
} from 'lucide-react';
import AppLogo from '@/components/app-logo';
import { NavMain } from '@/components/nav-main';
import { NavUser } from '@/components/nav-user';
import {
    Sidebar,
    SidebarContent,
    SidebarFooter,
    SidebarHeader,
    SidebarMenu,
    SidebarMenuButton,
    SidebarMenuItem,
    SidebarSeparator,
} from '@/components/ui/sidebar';
import { dashboard } from '@/routes';
import type { NavItem } from '@/types';

// nav main
const mainNavGroups = [
    {
        label: 'Navigation',
        items: [
            {
                title: 'Tableau de bord',
                href: dashboard(),
                icon: LayoutGrid,
            },
        ] satisfies NavItem[],
    },
    {
        label: 'Commerce',
        items: [
            {
                title: 'Clients',
                href: '/clients',
                icon: Building2,
            },
            {
                title: 'Opportunités',
                href: '/opportunities',
                icon: Zap,
            },
            {
                title: 'Activités',
                href: '/activities',
                icon: Activity,
            },
        ] satisfies NavItem[],
    },
];

// nav admin

const adminNavItems: NavItem[] = [
    {
        title: 'Équipe commerciale',
        href: '/admin/users',
        icon: Users,
    },
    {
        title: 'Statistiques',
        href: '/admin/stats',
        icon: BarChart3,
    },
    {
        title: 'Paramètres CRM',
        href: '/admin/settings',
        icon: Settings,
    },
];

export function AppSidebar() {
    const { auth } = usePage<any>().props;
    const isAdmin = auth.user?.is_admin === true;

    return (
        <Sidebar collapsible="icon" variant="inset">
            {/* logo */}
            <SidebarHeader>
                <SidebarMenu>
                    <SidebarMenuItem>
                        <SidebarMenuButton size="lg" asChild>
                            <Link href={dashboard()} prefetch>
                                <AppLogo />
                            </Link>
                        </SidebarMenuButton>
                    </SidebarMenuItem>
                </SidebarMenu>
            </SidebarHeader>

            {/* Navigation principale */}
            <SidebarContent>
                <NavMain groups={mainNavGroups} />

                {/* Section admin */}
                {isAdmin && (
                    <>
                        <SidebarSeparator className="my-2" />
                        <NavMain
                            groups={[
                                {
                                    label: 'Administration',
                                    items: adminNavItems,
                                },
                            ]}
                        />
                    </>
                )}
            </SidebarContent>

            <SidebarFooter>
                {isAdmin && (
                    <div className="mx-2 mb-1 flex items-center gap-1.5 rounded-md bg-amber-50 px-2 py-1.5 text-xs font-medium text-amber-700 group-data-[collapsible=icon]:hidden dark:bg-amber-950/40 dark:text-amber-400">
                        <ShieldCheck className="h-3.5 w-3.5 shrink-0" />
                        <span>Administrateur</span>
                    </div>
                )}
                <NavUser />
            </SidebarFooter>
        </Sidebar>
    );
}
