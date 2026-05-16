import { Head, router, useForm } from '@inertiajs/react';
import { Edit, Plus, Trash2, Users, X } from 'lucide-react';
import { useState } from 'react';
import AppLayout from '@/layouts/app-layout';
import type { BreadcrumbItem } from '@/types';

// types
interface Role {
    id_role: number;
    rolename: string;
}

interface User {
    id_user: number;
    name: string;
    email: string;
    role_id: number;
    role?: Role;
}

// Composant

export default function Index({
    users,
    roles,
}: {
    users: User[];
    roles: Role[];
}) {
    const breadcrumbs: BreadcrumbItem[] = [
        { title: 'Administration', href: '/admin/users' },
        { title: 'Équipe commerciale', href: '/admin/users' },
    ];

    const [isEditing, setIsEditing] = useState(false);
    const [editingUserId, setEditingUserId] = useState<number | null>(null);

    const { data, setData, post, put, reset, errors, processing } = useForm({
        name: '',
        email: '',
        password: '',
        role_id: '',
    });

    const openCreate = () => {
        setIsEditing(true);
        setEditingUserId(null);
        reset();
    };

    const openEdit = (user: User) => {
        setIsEditing(true);
        setEditingUserId(user.id_user);
        setData({
            name: user.name,
            email: user.email,
            password: '',
            role_id: String(user.role_id),
        });
    };

    const closeForm = () => {
        setIsEditing(false);
        setEditingUserId(null);
        reset();
    };

    const submit = (e: React.FormEvent) => {
        e.preventDefault();

        if (editingUserId) {
            put(`/admin/users/${editingUserId}`, {
                onSuccess: closeForm,
            });
        } else {
            post('/admin/users', {
                onSuccess: closeForm,
            });
        }
    };

    const deleteUser = (userId: number) => {
        if (
            window.confirm('Supprimer ce membre ? Cette action est définitive.')
        ) {
            router.delete(`/admin/users/${userId}`);
        }
    };

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Équipe commerciale" />

            <div className="mx-auto w-full max-w-5xl p-6">
                {/* En-tête */}
                <div className="mb-6 flex items-center justify-between border-b pb-4">
                    <div>
                        <h1 className="flex items-center gap-2 text-2xl font-bold">
                            <Users size={24} className="text-primary" />
                            Équipe commerciale
                        </h1>
                        <p className="text-sm text-muted-foreground">
                            Gérez les accès de vos commerciaux au CRM.
                        </p>
                    </div>
                    <button
                        onClick={openCreate}
                        className="flex items-center gap-2 rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
                    >
                        <Plus size={16} />
                        Ajouter un membre
                    </button>
                </div>

                {/* Formulaire création / édition */}
                {isEditing && (
                    <form
                        onSubmit={submit}
                        className="mb-8 grid grid-cols-1 gap-4 rounded-xl border bg-card p-6 shadow-sm md:grid-cols-2"
                    >
                        <div className="col-span-full mb-2 flex items-center justify-between border-b pb-2">
                            <h3 className="font-bold">
                                {editingUserId
                                    ? 'Modifier le compte'
                                    : 'Créer un nouveau compte'}
                            </h3>
                            <button
                                type="button"
                                onClick={closeForm}
                                className="flex items-center gap-1 text-sm text-muted-foreground hover:text-foreground"
                            >
                                <X size={14} />
                                Annuler
                            </button>
                        </div>

                        <div className="flex flex-col gap-1">
                            <label className="text-xs font-medium text-muted-foreground">
                                Nom complet
                            </label>
                            <input
                                type="text"
                                value={data.name}
                                onChange={(e) =>
                                    setData('name', e.target.value)
                                }
                                required
                                placeholder="Jean Dupont"
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-ring focus:outline-none"
                            />
                            {errors.name && (
                                <p className="text-xs text-destructive">
                                    {errors.name}
                                </p>
                            )}
                        </div>

                        <div className="flex flex-col gap-1">
                            <label className="text-xs font-medium text-muted-foreground">
                                Adresse e-mail
                            </label>
                            <input
                                type="email"
                                value={data.email}
                                onChange={(e) =>
                                    setData('email', e.target.value)
                                }
                                required
                                placeholder="jean@entreprise.com"
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-ring focus:outline-none"
                            />
                            {errors.email && (
                                <p className="text-xs text-destructive">
                                    {errors.email}
                                </p>
                            )}
                        </div>

                        <div className="flex flex-col gap-1">
                            <label className="text-xs font-medium text-muted-foreground">
                                Mot de passe{' '}
                                {editingUserId && (
                                    <span className="font-normal">
                                        (laisser vide pour ne pas changer)
                                    </span>
                                )}
                            </label>
                            <input
                                type="password"
                                value={data.password}
                                onChange={(e) =>
                                    setData('password', e.target.value)
                                }
                                required={!editingUserId}
                                placeholder={
                                    editingUserId
                                        ? '••••••••'
                                        : 'Minimum 8 caractères'
                                }
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-ring focus:outline-none"
                            />
                            {errors.password && (
                                <p className="text-xs text-destructive">
                                    {errors.password}
                                </p>
                            )}
                        </div>

                        <div className="flex flex-col gap-1">
                            <label className="text-xs font-medium text-muted-foreground">
                                Rôle
                            </label>
                            <select
                                value={data.role_id}
                                onChange={(e) =>
                                    setData('role_id', e.target.value)
                                }
                                required
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm focus:ring-2 focus:ring-ring focus:outline-none"
                            >
                                <option value="" disabled>
                                    Sélectionner un rôle
                                </option>
                                {roles.map((role) => (
                                    <option
                                        key={role.id_role}
                                        value={role.id_role}
                                    >
                                        {role.rolename}
                                    </option>
                                ))}
                            </select>
                            {errors.role_id && (
                                <p className="text-xs text-destructive">
                                    {errors.role_id}
                                </p>
                            )}
                        </div>

                        <div className="col-span-full mt-2 flex justify-end">
                            <button
                                type="submit"
                                disabled={processing}
                                className="rounded-md bg-primary px-6 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90 disabled:opacity-50"
                            >
                                {processing
                                    ? 'Enregistrement...'
                                    : editingUserId
                                      ? 'Mettre à jour'
                                      : 'Enregistrer'}
                            </button>
                        </div>
                    </form>
                )}

                <div className="overflow-hidden rounded-xl border bg-card shadow-sm">
                    <table className="w-full text-left text-sm">
                        <thead className="bg-muted/50 text-xs text-foreground uppercase">
                            <tr>
                                <th className="px-6 py-4">Nom</th>
                                <th className="px-6 py-4">E-mail</th>
                                <th className="px-6 py-4">Rôle</th>
                                <th className="px-6 py-4 text-right">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {users.length === 0 && (
                                <tr>
                                    <td
                                        colSpan={4}
                                        className="px-6 py-8 text-center text-muted-foreground"
                                    >
                                        Aucun membre dans l'équipe.
                                    </td>
                                </tr>
                            )}
                            {users.map((user) => (
                                <tr
                                    key={user.id_user}
                                    className="border-b last:border-0 hover:bg-muted/20"
                                >
                                    <td className="px-6 py-4 font-medium text-foreground">
                                        {user.name}
                                    </td>
                                    <td className="px-6 py-4 text-muted-foreground">
                                        {user.email}
                                    </td>
                                    <td className="px-6 py-4">
                                        <span
                                            className={`rounded-full px-2.5 py-1 text-xs font-semibold ${
                                                user.role?.rolename === 'admin'
                                                    ? 'bg-amber-100 text-amber-700 dark:bg-amber-950/40 dark:text-amber-400'
                                                    : user.role?.rolename === 'manager'
                                                        ? 'bg-red-100 text-red-700 dark:bg-red-950/40 dark:text-red-400'
                                                        : 'bg-blue-100 text-blue-700 dark:bg-blue-950/40 dark:text-blue-400'
                                            }`}
                                        >
                                            {user.role?.rolename ?? 'N/A'}
                                        </span>
                                    </td>
                                    <td className="px-6 py-4 text-right">
                                        <div className="flex items-center justify-end gap-3">
                                            <button
                                                onClick={() => openEdit(user)}
                                                title="Modifier"
                                                className="text-blue-500 hover:text-blue-700"
                                            >
                                                <Edit size={16} />
                                            </button>
                                            <button
                                                onClick={() =>
                                                    deleteUser(user.id_user)
                                                }
                                                title="Supprimer"
                                                className="text-destructive hover:text-red-700"
                                            >
                                                <Trash2 size={16} />
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </AppLayout>
    );
}
