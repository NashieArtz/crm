import { Form } from '@inertiajs/react';
import InputError from './input-error';
import PasswordInput from './password-input';
import TextLink from './text-link';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import {
    Field,
    FieldDescription,
    FieldGroup,
    FieldLabel,
    FieldSeparator,
} from '@/components/ui/field';
import { Input } from '@/components/ui/input';
import { cn } from '@/lib/utils';
import { register } from '@/routes';
import { store } from '@/routes/login';
import { request } from '@/routes/password';

type Props = {
    status?: string;
    canResetPassword: boolean;
    canRegister: boolean;
    className: string;
};

export function LoginForm({
    status,
    canRegister,
    canResetPassword,
    className,
    ...props
}: Props) {
    return (
        <div className={cn('flex flex-col gap-6', className)} {...props}>
            <Card className="overflow-hidden p-0">
                <CardContent className="grid p-0 md:grid-cols-2">
                    <Form
                        className="p-6 md:p-8"
                        {...store.form()}
                        resetOnSuccess={['password']}
                    >
                        {({ processing, errors }) => (
                            <FieldGroup>
                                <div className="flex flex-col items-center gap-2 text-center">
                                    <h1 className="text-2xl font-bold">
                                        Welcome back
                                    </h1>
                                    <p className="text-balance text-muted-foreground">
                                        Login to your Acme Inc account
                                    </p>
                                </div>
                                <Field>
                                    <FieldLabel htmlFor="email">
                                        Email
                                    </FieldLabel>
                                    <Input
                                        id="email"
                                        type="email"
                                        name="email"
                                        autoFocus
                                        tabIndex={1}
                                        placeholder="enail@example.com"
                                        autoComplete="email"
                                        required
                                    />
                                    <InputError message={errors.email} />
                                </Field>
                                <Field>
                                    <div className="flex items-center">
                                        <FieldLabel htmlFor="password">
                                            Password
                                        </FieldLabel>
                                        {canResetPassword && (
                                            <TextLink
                                                href={request()}
                                                className="ml-auto text-sm underline-offset-2 hover:underline"
                                                tabIndex={5}
                                            >
                                                Forgot your password?
                                            </TextLink>
                                        )}
                                    </div>
                                    <PasswordInput
                                        id="password"
                                        name="password"
                                        required
                                        tabIndex={2}
                                        autoComplete="current-password"
                                        placeholder="Password"
                                    />
                                    <InputError message={errors.password} />
                                </Field>
                                <Field>
                                    <Button
                                        type="submit"
                                        className="mt-4 w-full"
                                        tabIndex={4}
                                        disabled={processing}
                                        data-test="login-button"
                                    >
                                        Login
                                    </Button>
                                </Field>
                                {canRegister && (
                                    <FieldDescription className="text-center">
                                        Don't have an account?{' '}
                                        <TextLink
                                            href={register()}
                                            tabIndex={5}
                                        >
                                            Sign up
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
                    <div className="relative hidden bg-muted md:block">
                        <img
                            src="https://picsum.photos/200"
                            alt="Image"
                            className="absolute inset-0 h-full w-full object-cover dark:brightness-[0.2] dark:grayscale"
                        />
                    </div>
                </CardContent>
            </Card>
            <FieldDescription className="px-6 text-center">
                By clicking continue, you agree to our{' '}
                <a href="#">Terms of Service</a> and{' '}
                <a href="#">Privacy Policy</a>.
            </FieldDescription>
        </div>
    );
}
