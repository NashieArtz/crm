# CRM Les Vieux Biscuits

Application CRM full-stack developpee pour la gestion de portefeuille clients, le suivi des opportunites commerciales et l'administration d'equipe. Ce projet est base sur une architecture monolithique moderne.

## Technologies principales

* Backend : Laravel 12 (PHP 8.4)
* Frontend : React 18, Inertia.js
* Base de donnees : PostgreSQL
* Interface : Tailwind CSS, Shadcn/UI, Lucide React
* Visualisation de donnees : Recharts

## Fonctionnalites

* Tableau de bord interactif (KPIs, graphiques de revenus, activites recentes).
* Gestion complete des clients et des contacts associes.
* Suivi des opportunites commerciales (tunnel de vente, montants, statuts).
* Historique des activites (appels, emails, reunions).
* Espace Administration : gestion des membres de l'equipe (commerciaux), des roles et acces.
* Parametres globaux du CRM (configuration dynamique en base de donnees).
* Systeme d'assignation de remplacants (backups) sur les dossiers clients.

## Pre-requis

* PHP >= 8.2
* Composer
* Node.js (v18+) et npm
* Serveur PostgreSQL actif

## Installation

### 1. Cloner le depot et acceder au dossier

```bash
git clone https://gitlab.com/Zedeska/biscuit.git
cd crm-les-vieux-biscuits
```

### 2. Installer les dependances Backend (PHP)

```bash
composer install
```

### 3. Installer les dependances Frontend (JavaScript)

```bash
npm install
```

### 4. Configuration de l'environnement

Creer le fichier de configuration local en dupliquant le fichier d'exemple, puis generer la cle de chiffrement Laravel.

```bash
cp .env.example .env
php artisan key:generate
```

Ouvrir le fichier `.env` a la racine du projet et configurer la connexion a la base de donnees PostgreSQL :

```env
DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=biscuit
DB_USERNAME=postgres
DB_PASSWORD=votre_mot_de_passe
```

### 5. Import de la base de donnees (Recommande)

Pour garantir que tous les collaborateurs disposent exactement du meme jeu de donnees (clients, historique, utilisateurs), le projet utilise un fichier de sauvegarde SQL fourni a la racine du projet (`backup_biscuit.sql`).

Assurez-vous d'abord d'avoir cree une base de donnees vide nommée `biscuit` (ou le nom defini dans votre `.env`) dans votre outil PostgreSQL (pgAdmin, DBeaver, ou en ligne de commande).

Ensuite, depuis la racine de votre projet, executez la commande suivante pour importer la structure et les donnees :

```bash
psql -U postgres -h 127.0.0.1 -d biscuit < backup_biscuit.sql
```
*Note : Il n'est pas necessaire d'executer `php artisan migrate` ou `php artisan db:seed` apres cette etape.*

### 6. Compilation et lancement

L'application necessite deux serveurs en cours d'execution simultanee en environnement de developpement.

Dans un premier terminal, compiler les assets frontend avec Vite :

```bash
npm run dev
```

Dans un second terminal, demarrer le serveur PHP Laravel :

```bash
php artisan serve
```

L'application est desormais accessible via votre navigateur a l'adresse : `http://localhost:8000` (ou via le domaine configure dans votre environnement local comme Laragon, par exemple `http://biscuit.test`).

## Acces Administrateur

Le fichier d'import SQL contient deja un compte administrateur preconfigure. Utilisez ces identifiants pour vous connecter et acceder au panel de gestion d'equipe :

* Email : admin1@crm.fr
* Mot de passe : admin1234

## Acces User
* Email : lucas@crm.fr
* Mot de passe : lucas1234
