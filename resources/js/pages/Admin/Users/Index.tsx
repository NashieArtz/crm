import { Head, router, useForm } from '@inertiajs/react';
import { Edit, Plus, Trash2, Users } from 'lucide-react';
import { useState } from 'react';
import AppLayout from '@/layouts/app-layout';
import type { BreadcrumbItem } from '@/types';

export default function Index({
    users,
    roles,
}: {
    users: any[];
    roles: any[];
}) {
    const breadcrumbs: BreadcrumbItem[] = [
        { title: 'Administration', href: '#' },
        { title: 'Équipe', href: '/users' },
    ];

    const [isEditing, setIsEditing] = useState(false);
    const [editingUserId, setEditingUserId] = useState<number | null>(null);

    const { data, setData, post, put, reset, errors, processing } = useForm({
        name: '',
        email: '',
        password: '',
        role_id: '',
    });

    // Open l'formulaire en mode création
    const openCreate = () => {
        setIsEditing(true);
        setEditingUserId(null);
        reset();
    };

    // Ouvre le formulaire en mode édition
    const openEdit = (user: any) => {
        setIsEditing(true);
        setEditingUserId(user.id_user);
        setData({
            name: user.name,
            email: user.email,
            // Vide ppour sécu
            password: '',
            role_id: user.role_id,
        });
    };

    const submit = (e: React.FormEvent) => {
        e.preventDefault();
        const options = {
            onSuccess: () => {
                setIsEditing(false);
                reset();
            },
        };

        if (editingUserId) {
            put(`/users/${editingUserId}`, options);
        } else {
            post('/users', options);
        }
    };

    const deleteUser = (userId: number) => {
        if (
            window.confirm(
                'Supprimer ce commercial ? Cette action est définitive.',
            )
        ) {
            router.delete(`/users/${userId}`);
        }
    };

    return (
        <AppLayout breadcrumbs={breadcrumbs}>
            <Head title="Gestion de l'équipe" />

            <div className="mx-auto w-full max-w-5xl p-6">
                <div className="mb-6 flex items-center justify-between border-b pb-4">
                    <div>
                        <h1 className="flex items-center gap-2 text-2xl font-bold">
                            <Users size={24} className="text-primary" /> Membres
                            de l'équipe
                        </h1>
                        <p className="text-sm text-muted-foreground">
                            Gérez les accès de vos commerciaux au CRM.
                        </p>
                    </div>
                    <button
                        onClick={openCreate}
                        className="flex items-center gap-2 rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
                    >
                        <Plus size={16} /> Ajouter
                    </button>
                </div>

                {/* Form create et edit */}
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
                                onClick={() => setIsEditing(false)}
                                className="text-sm text-muted-foreground hover:underline"
                            >
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
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                            />
                            {errors.name && (
                                <p className="text-xs text-destructive">
                                    {errors.name}
                                </p>
                            )}
                        </div>

                        <div className="flex flex-col gap-1">
                            <label className="text-xs font-medium text-muted-foreground">
                                Adresse Email
                            </label>
                            <input
                                type="email"
                                value={data.email}
                                onChange={(e) =>
                                    setData('email', e.target.value)
                                }
                                required
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
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
                                {editingUserId &&
                                    '(Laisser vide pour ne pas changer)'}
                            </label>
                            <input
                                type="password"
                                value={data.password}
                                onChange={(e) =>
                                    setData('password', e.target.value)
                                }
                                required={!editingUserId}
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
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
                                className="w-full rounded-md border bg-background px-3 py-2 text-sm"
                            >
                                <option value="" disabled>
                                    Sélectionner un rôle
                                </option>
                                {roles.map((role) => (
                                    <option key={role.id_role} value={role.id_role}>
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
                                {editingUserId
                                    ? 'Mettre à jour'
                                    : 'Enregistrer'}
                            </button>
                        </div>
                    </form>
                )}

                {/* Tableau users */}
                <div className="overflow-hidden rounded-xl border bg-card shadow-sm">
                    <table className="w-full text-left text-sm text-muted-foreground">
                        <thead className="bg-muted/50 text-xs text-foreground uppercase">
                            <tr>
                                <th className="px-6 py-4">Nom</th>
                                <th className="px-6 py-4">Email</th>
                                <th className="px-6 py-4">Rôle</th>
                                <th className="px-6 py-4 text-right">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            {users.map((user) => (
                                <tr
                                    key={user.id_user}
                                    className="border-b last:border-0 hover:bg-muted/20"
                                >
                                    <td className="px-6 py-4 font-medium text-foreground">
                                        {user.name}
                                    </td>
                                    <td className="px-6 py-4">{user.email}</td>
                                    <td className="px-6 py-4">
                                        <span
                                            className={`rounded-full px-2 py-1 text-xs font-bold ${user.role?.rolename === 'admin' ? 'bg-red-100 text-red-700' : 'bg-blue-100 text-blue-700'}`}
                                        >
                                            {user.role?.rolename || 'N/A'}
                                        </span>
                                    </td>
                                    <td className="flex justify-end gap-3 px-6 py-4 text-right">
                                        <button
                                            onClick={() => openEdit(user)}
                                            className="text-blue-500 hover:text-blue-700"
                                        >
                                            <Edit size={16} />
                                        </button>
                                        <button
                                            onClick={() =>
                                                deleteUser(user.id_user)
                                            }
                                            className="text-destructive hover:text-red-700"
                                        >
                                            <Trash2 size={16} />
                                        </button>
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
