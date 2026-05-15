import { Form } from '@inertiajs/react';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import {
    Field,
    FieldDescription,
    FieldGroup,
    FieldLabel,
} from '@/components/ui/field';
import { Input } from '@/components/ui/input';
import { cn } from '@/lib/utils';
import { register } from '@/routes';
import { store } from '@/routes/login';
import { request } from '@/routes/password';
import InputError from './input-error';
import PasswordInput from './password-input';
import TextLink from './text-link';

type Props = {
    status?: string;
    canResetPassword?: boolean;
    canRegister?: boolean;
    className?: string;
};

export function LoginForm({
    status,
    canRegister = true,
    canResetPassword = true,
    className,
    ...props
}: Props) {
    return (
        <div className={cn('flex flex-col gap-6', className)} {...props}>
            <Card className="overflow-hidden border-none bg-transparent p-0 shadow-none">
                <CardContent className="p-0">
                    <Form
                        className="p-6 md:p-8"
                        {...store.form()}
                        resetOnSuccess={['password']}
                    >
                        {({ processing, errors }) => (
                            <FieldGroup>
                                <div className="mb-6 flex hidden flex-col items-center gap-2 text-center lg:flex">
                                    <h1 className="text-3xl font-extrabold text-slate-900">
                                        Connexion
                                    </h1>
                                    <p className="font-medium text-balance text-slate-500">
                                        Identifiez-vous pour accéder à vos
                                        données CRM
                                    </p>
                                </div>
                                <Field>
                                    <FieldLabel
                                        htmlFor="email"
                                        className="text-slate-900"
                                    >
                                        Adresse e-mail
                                    </FieldLabel>
                                    <Input
                                        id="email"
                                        type="email"
                                        name="email"
                                        autoFocus
                                        tabIndex={1}
                                        placeholder="email@exemple.fr"
                                        autoComplete="email"
                                        required
                                        className="border-slate-300 bg-white text-slate-900"
                                    />
                                    <InputError message={errors.email} />
                                </Field>
                                <Field>
                                    <div className="flex items-center">
                                        <FieldLabel
                                            htmlFor="password"
                                            className="text-slate-900"
                                        >
                                            Mot de passe
                                        </FieldLabel>
                                        {canResetPassword && (
                                            <TextLink
                                                href={request()}
                                                className="ml-auto text-sm text-slate-600 underline-offset-2 hover:text-blue-700 hover:underline"
                                                tabIndex={5}
                                            >
                                                Mot de passe oublié ?
                                            </TextLink>
                                        )}
                                    </div>
                                    <PasswordInput
                                        id="password"
                                        name="password"
                                        required
                                        tabIndex={2}
                                        autoComplete="current-password"
                                        placeholder="Mot de passe"
                                        className="border-slate-300 bg-white text-slate-900"
                                    />
                                    <InputError message={errors.password} />
                                </Field>
                                <Field>
                                    <Button
                                        type="submit"
                                        className="mt-4 w-full bg-blue-600 text-white hover:bg-blue-700"
                                        tabIndex={4}
                                        disabled={processing}
                                        data-test="login-button"
                                    >
                                        Se connecter
                                    </Button>
                                </Field>
                                {canRegister && (
                                    <FieldDescription className="text-center text-slate-600">
                                        Vous n'avez pas de compte ?{' '}
                                        <TextLink
                                            href={register()}
                                            tabIndex={5}
                                            className="font-semibold text-blue-600 hover:text-blue-700"
                                        >
                                            S'inscrire
                                        </TextLink>
                                    </FieldDescription>
                                )}
                            </FieldGroup>
                        )}
                    </Form>
                    {status && (
                        <div className="mb-4 text-center text-sm font-medium text-green-600">
                            {status}
                        </div>
                    )}
                </CardContent>
            </Card>
            <FieldDescription className="px-6 text-center text-slate-500">
                En cliquant sur continuer, vous acceptez les{' '}
                <a
                    href="#"
                    className="text-slate-600 underline hover:text-blue-600"
                >
                    Conditions d'utilisation
                </a>{' '}
                et la{' '}
                <a
                    href="#"
                    className="text-slate-600 underline hover:text-blue-600"
                >
                    Politique de confidentialité
                </a>
                .
            </FieldDescription>
        </div>
    );
}
