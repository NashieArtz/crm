# CRM Les Vieux Biscuits

Application CRM full-stack développée pour la gestion de portefeuille clients, le suivi des opportunités commerciales et l'administration d'équipe. Ce projet est basé sur une architecture monolithique moderne.

## Technologies principales

* **Backend** : Laravel 12 (PHP 8.4)
* **Frontend** : React 18, Inertia.js
* **Base de données** : PostgreSQL
* **Interface** : Tailwind CSS, Shadcn/UI, Lucide React
* **Visualisation de données** : Recharts

## Fonctionnalités

* **Tableau de bord interactif** : KPIs, graphiques de revenus, activités récentes.
* **Gestion complète** : Des clients et des contacts associés.
* **Suivi commercial** : Tunnel de vente, montants, statuts.
* **Historique des activités** : Appels, e-mails, réunions.
* **Espace Administration** : Gestion des membres de l'équipe (commerciaux), des rôles et accès.
* **Paramètres globaux** : Configuration dynamique en base de données.
* **Système d'assignation** : Gestion des remplaçants (backups) sur les dossiers clients.

## Pré-requis

* PHP >= 8.2
* Composer
* Node.js (v18+) et npm
* Serveur PostgreSQL actif

## Installation

### 1. Cloner le dépôt et accéder au dossier

```bash
git clone https://gitlab.com/Zedeska/biscuit.git
cd crm-les-vieux-biscuits
```

### 2. Installer les dépendances Backend (PHP)

```bash
composer install
```

### 3. Installer les dépendances Frontend (JavaScript)

```bash
npm install
```

### 4. Configuration de l'environnement

Créer le fichier de configuration local en dupliquant le fichier d'exemple, puis générer la clé de chiffrement Laravel.

```bash
cp .env.example .env
php artisan key:generate
```

Ouvrir le fichier `.env` à la racine du projet et configurer la connexion à la base de données PostgreSQL :

```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=biscuit
DB_USERNAME=postgres
DB_PASSWORD=votre_mot_de_passe
```

### 5. Import de la base de données (Recommandé)

Pour garantir que tous les collaborateurs disposent exactement du même jeu de données (clients, historique, utilisateurs), le projet utilise un fichier de sauvegarde SQL fourni à la racine du projet (`backup_biscuit.sql`).

Assurez-vous d'abord d'avoir créé une base de données vide nommée `biscuit` (ou le nom défini dans votre `.env`) dans votre outil PostgreSQL (pgAdmin, DBeaver, ou en ligne de commande).

Ensuite, depuis la racine de votre projet, exécutez la commande suivante pour importer la structure et les données :

```bash
psql -U postgres -h 127.0.0.1 -d biscuit < backup_biscuit.sql
```
*Note : Il n'est pas nécessaire d'exécuter `php artisan migrate` ou `php artisan db:seed` après cette étape.*

### 6. Compilation et lancement

L'application nécessite deux serveurs en cours d'exécution simultanée en environnement de développement.

Dans un premier terminal, compilez les assets frontend avec Vite :

```bash
npm run dev
```

Dans un second terminal, démarrez le serveur PHP Laravel :

```bash
php artisan serve
```

L'application est désormais accessible via votre navigateur à l'adresse : `http://localhost:8000` (ou via le domaine configuré dans votre environnement local comme Laragon, par exemple `http://biscuit.test`).

## Accès Administrateur

Le fichier d'import SQL contient déjà un compte administrateur préconfiguré. Utilisez ces identifiants pour vous connecter et accéder au panel de gestion d'équipe :

* **Email** : admin1@crm.fr
* **Mot de passe** : admin1234


## Acces User
* Email : lucas@crm.fr
* Mot de passe : lucas1234
=======
## Accès Utilisateur
* **Email** : lucas@crm.fr
* **Mot de passe** : lucas1234

