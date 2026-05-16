import { Form, Head, Link } from '@inertiajs/react';
import InputError from '@/components/input-error';
import PasswordInput from '@/components/password-input';
import TextLink from '@/components/text-link';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Spinner } from '@/components/ui/spinner';
import AuthLayout from '@/layouts/auth-layout';
import { welcome } from '@/routes';
import { store } from '@/routes/register';

export default function Register() {
    return (
        <div className="relative min-h-screen w-full bg-slate-50">
            <div className="absolute top-8 left-8 z-50">
                <Link
                    href="/"
                    className="flex items-center gap-2 text-sm font-semibold text-slate-600 transition-colors hover:text-blue-700"
                >
                    <svg
                        xmlns="http://www.w3.org/2000/svg"
                        fill="none"
                        viewBox="0 0 24 24"
                        strokeWidth={2}
                        stroke="currentColor"
                        className="h-4 w-4"
                    >
                        <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"
                        />
                    </svg>
                    Retour à l'accueil
                </Link>
            </div>

            <AuthLayout
                title="Créer un compte"
                description="Entrez vos coordonnées ci-dessous pour créer votre compte"
            >
                <Head title="Inscription" />
                <Form
                    {...store.form()}
                    resetOnSuccess={['password', 'password_confirmation']}
                    disableWhileProcessing
                    className="flex flex-col gap-6"
                >
                    {({ processing, errors }) => (
                        <>
                            <div className="grid gap-6">
                                <div className="grid gap-2">
                                    <Label htmlFor="name">Nom</Label>
                                    <Input
                                        id="name"
                                        type="text"
                                        required
                                        autoFocus
                                        tabIndex={1}
                                        autoComplete="name"
                                        name="name"
                                        placeholder="Nom complet"
                                    />
                                    <InputError
                                        message={errors.name}
                                        className="mt-2"
                                    />
                                </div>

                                <div className="grid gap-2">
                                    <Label htmlFor="email">Adresse e-mail</Label>
                                    <Input
                                        id="email"
                                        type="email"
                                        required
                                        tabIndex={2}
                                        autoComplete="email"
                                        name="email"
                                        placeholder="email@exemple.fr"
                                    />
                                    <InputError message={errors.email} />
                                </div>

                                <div className="grid gap-2">
                                    <Label htmlFor="password">Mot de passe</Label>
                                    <PasswordInput
                                        id="password"
                                        required
                                        tabIndex={3}
                                        autoComplete="new-password"
                                        name="password"
                                        placeholder="Mot de passe"
                                    />
                                    <InputError message={errors.password} />
                                </div>

                                <div className="grid gap-2">
                                    <Label htmlFor="password_confirmation">
                                        Confirmer le mot de passe
                                    </Label>
                                    <PasswordInput
                                        id="password_confirmation"
                                        required
                                        tabIndex={4}
                                        autoComplete="new-password"
                                        name="password_confirmation"
                                        placeholder="Confirmer le mot de passe"
                                    />
                                    <InputError
                                        message={errors.password_confirmation}
                                    />
                                </div>

                                <Button
                                    type="submit"
                                    className="mt-2 w-full bg-blue-600 hover:bg-blue-700 text-white"
                                    tabIndex={5}
                                    data-test="register-user-button"
                                >
                                    {processing && <Spinner />}
                                    Créer le compte
                                </Button>
                            </div>

                            <div className="text-center text-sm text-muted-foreground">
                                Vous avez déjà un compte ?{' '}
                                <TextLink href={welcome()} tabIndex={6}>
                                    Se connecter
                                </TextLink>
                            </div>
                        </>
                    )}
                </Form>
            </AuthLayout>
        </div>
    );
}
