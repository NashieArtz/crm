import { Head, Link, usePage } from '@inertiajs/react';
import { LoginForm } from '@/components/login-form';
import { dashboard, register } from '@/routes';

export default function Welcome({
    canRegister = true,
}: {
    canRegister?: boolean;
}) {
    const { auth } = usePage().props;

    return (
        <>
            <Head title="Welcome">
                <link rel="preconnect" href="https://fonts.bunny.net" />
                <link
                    href="https://fonts.bunny.net/css?family=inter:400,500,600,700"
                    rel="stylesheet"
                />
            </Head>

            <div className="flex min-h-screen w-full bg-slate-50 font-sans">
                <div className="hidden w-1/2 flex-col justify-between bg-gradient-to-br from-blue-900 to-blue-700 p-12 text-white lg:flex">
                    <div className="flex items-center gap-3 text-2xl font-bold">
                        <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-white text-blue-900">
                            <svg
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 24 24"
                                fill="currentColor"
                                className="h-6 w-6"
                            >
                                <path d="M12 2.25a.75.75 0 01.75.75v2.25a.75.75 0 01-1.5 0V3a.75.75 0 01.75-.75zM7.5 12a4.5 4.5 0 119 0 4.5 4.5 0 01-9 0zM18.894 6.166a.75.75 0 00-1.06-1.06l-1.591 1.59a.75.75 0 101.06 1.061l1.591-1.59zM21.75 12a.75.75 0 01-.75.75h-2.25a.75.75 0 010-1.5H21a.75.75 0 01.75.75zM17.834 18.894a.75.75 0 001.06-1.06l-1.59-1.591a.75.75 0 10-1.061 1.06l1.59 1.591zM12 18a.75.75 0 01.75.75V21a.75.75 0 01-1.5 0v-2.25A.75.75 0 0112 18zM7.22 17.834a.75.75 0 00-1.06 1.06l1.591 1.59a.75.75 0 001.061-1.061l-1.591-1.59zM6 12a.75.75 0 01-.75.75H3a.75.75 0 010-1.5h2.25A.75.75 0 016 12zM6.166 5.106a.75.75 0 001.06 1.06l1.59-1.591a.75.75 0 10-1.061-1.06l-1.59 1.591z" />
                            </svg>
                        </div>
                        CRM Enterprise
                    </div>

                    <div className="mb-12 max-w-lg">
                        <h1 className="mb-6 text-4xl leading-tight font-extrabold tracking-tight">
                            Pilotez vos ventes et vos relations clients
                        </h1>
                        <p className="text-lg font-medium text-blue-100">
                            Une solution puissante conçue pour simplifier votre
                            cycle de vente et centraliser toutes vos
                            opportunités commerciales dans une interface unifiée
                        </p>
                    </div>

                    <div className="text-sm font-medium text-blue-300">
                        © 2026 Tous droits réservés
                    </div>
                </div>

                <div className="relative flex w-full flex-col items-center justify-center p-8 lg:w-1/2">
                    <header className="absolute top-8 right-8 w-full text-sm">
                        <nav className="flex items-center justify-end gap-6">
                            {auth.user ? (
                                <Link
                                    href={dashboard()}
                                    className="rounded-md bg-blue-600 px-5 py-2.5 font-semibold text-white shadow-sm transition-all hover:bg-blue-700 hover:shadow"
                                >
                                    Accéder au Dashboard
                                </Link>
                            ) : (
                                <>
                                    {canRegister && (
                                        <Link
                                            href={register()}
                                            className="rounded-md border border-slate-200 bg-white px-5 py-2.5 font-semibold text-slate-700 shadow-sm transition-all hover:bg-slate-50"
                                        >
                                            Créer un compte
                                        </Link>
                                    )}
                                </>
                            )}
                        </nav>
                    </header>

                    <div className="w-full max-w-lg xl:max-w-xl">
                        <div className="mb-6 text-center lg:hidden">
                            <h2 className="text-3xl font-extrabold text-blue-900">
                                CRM Enterprise
                            </h2>
                            <p className="mt-2 text-sm text-slate-500">
                                Connectez vous pour gérer vos ventes
                            </p>
                        </div>

                        <div className="rounded-xl border border-slate-100 bg-white shadow-sm lg:border-none lg:bg-transparent lg:shadow-none">
                            <LoginForm
                                canRegister={canRegister}
                                canResetPassword={true}
                            />
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}
