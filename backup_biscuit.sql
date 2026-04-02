--
-- PostgreSQL database dump
--

\restrict ufz0dyQ8tCgcU9vo19faOgnncTguq2fwIATif73Qfw98a3gMPZ6qtXctBUYSQf3

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activities (
    id_activity bigint NOT NULL,
    type character varying(255),
    description text,
    date_activity timestamp(0) without time zone NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT activities_type_check CHECK (((type)::text = ANY ((ARRAY['call'::character varying, 'email'::character varying, 'meeting'::character varying, 'task'::character varying, 'note'::character varying])::text[])))
);


ALTER TABLE public.activities OWNER TO postgres;

--
-- Name: activities_id_activity_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activities_id_activity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activities_id_activity_seq OWNER TO postgres;

--
-- Name: activities_id_activity_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activities_id_activity_seq OWNED BY public.activities.id_activity;


--
-- Name: activity_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activity_client (
    id_activity_client bigint NOT NULL,
    activity_id bigint NOT NULL,
    client_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.activity_client OWNER TO postgres;

--
-- Name: activity_client_id_activity_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activity_client_id_activity_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.activity_client_id_activity_client_seq OWNER TO postgres;

--
-- Name: activity_client_id_activity_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activity_client_id_activity_client_seq OWNED BY public.activity_client.id_activity_client;


--
-- Name: addresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.addresses (
    id_address bigint NOT NULL,
    street character varying(100),
    number character varying(255),
    postal_code character varying(30),
    complement character varying(100),
    client_id bigint NOT NULL,
    city_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.addresses OWNER TO postgres;

--
-- Name: addresses_id_address_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.addresses_id_address_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_id_address_seq OWNER TO postgres;

--
-- Name: addresses_id_address_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.addresses_id_address_seq OWNED BY public.addresses.id_address;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id_city bigint NOT NULL,
    name character varying(100) NOT NULL,
    country_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- Name: cities_id_city_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_city_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_city_seq OWNER TO postgres;

--
-- Name: cities_id_city_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_city_seq OWNED BY public.cities.id_city;


--
-- Name: client_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user (
    id_client_user bigint NOT NULL,
    user_id bigint NOT NULL,
    client_id bigint NOT NULL,
    is_primary boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.client_user OWNER TO postgres;

--
-- Name: client_user_id_client_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_user_id_client_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_user_id_client_user_seq OWNER TO postgres;

--
-- Name: client_user_id_client_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_user_id_client_user_seq OWNED BY public.client_user.id_client_user;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id_client bigint NOT NULL,
    company_name character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(30),
    website character varying(100),
    income integer,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clients_id_client_seq OWNER TO postgres;

--
-- Name: clients_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_client_seq OWNED BY public.clients.id_client;


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id_contact bigint NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    type character varying(255),
    description text,
    client_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT contacts_type_check CHECK (((type)::text = ANY ((ARRAY['lead'::character varying, 'prospect'::character varying, 'customer'::character varying, 'partner'::character varying])::text[])))
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_contact_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_contact_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_contact_seq OWNER TO postgres;

--
-- Name: contacts_id_contact_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_contact_seq OWNED BY public.contacts.id_contact;


--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id_country bigint NOT NULL,
    name character varying(100) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_id_country_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_id_country_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_id_country_seq OWNER TO postgres;

--
-- Name: countries_id_country_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_id_country_seq OWNED BY public.countries.id_country;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: opportunities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.opportunities (
    id_opportunity bigint NOT NULL,
    source character varying(100),
    details text,
    status character varying(255) DEFAULT 'qualification'::character varying NOT NULL,
    type character varying(255) DEFAULT 'new_business'::character varying NOT NULL,
    amount numeric(15,2),
    closed_date timestamp(0) without time zone NOT NULL,
    client_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT opportunities_status_check CHECK (((status)::text = ANY ((ARRAY['qualification'::character varying, 'proposal'::character varying, 'negotiation'::character varying, 'closed_won'::character varying, 'closed_lost'::character varying])::text[]))),
    CONSTRAINT opportunities_type_check CHECK (((type)::text = ANY ((ARRAY['new_business'::character varying, 'upsell'::character varying, 'renewal'::character varying])::text[])))
);


ALTER TABLE public.opportunities OWNER TO postgres;

--
-- Name: opportunities_id_opportunity_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.opportunities_id_opportunity_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.opportunities_id_opportunity_seq OWNER TO postgres;

--
-- Name: opportunities_id_opportunity_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.opportunities_id_opportunity_seq OWNED BY public.opportunities.id_opportunity;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id_role bigint NOT NULL,
    rolename character varying(255) DEFAULT 'sales_rep'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT roles_rolename_check CHECK (((rolename)::text = ANY ((ARRAY['admin'::character varying, 'manager'::character varying, 'sales_rep'::character varying])::text[])))
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_role_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_role_seq OWNER TO postgres;

--
-- Name: roles_id_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_role_seq OWNED BY public.roles.id_role;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id integer NOT NULL,
    key character varying(255) NOT NULL,
    value text,
    created_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.settings_id_seq OWNER TO postgres;

--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_user bigint NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(200) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(100) NOT NULL,
    last_login timestamp(0) without time zone,
    remember_token character varying(100),
    role_id bigint NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    two_factor_secret text,
    two_factor_recovery_codes text,
    two_factor_confirmed_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_user_seq OWNER TO postgres;

--
-- Name: users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_user_seq OWNED BY public.users.id_user;


--
-- Name: activities id_activity; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities ALTER COLUMN id_activity SET DEFAULT nextval('public.activities_id_activity_seq'::regclass);


--
-- Name: activity_client id_activity_client; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_client ALTER COLUMN id_activity_client SET DEFAULT nextval('public.activity_client_id_activity_client_seq'::regclass);


--
-- Name: addresses id_address; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id_address SET DEFAULT nextval('public.addresses_id_address_seq'::regclass);


--
-- Name: cities id_city; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id_city SET DEFAULT nextval('public.cities_id_city_seq'::regclass);


--
-- Name: client_user id_client_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user ALTER COLUMN id_client_user SET DEFAULT nextval('public.client_user_id_client_user_seq'::regclass);


--
-- Name: clients id_client; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id_client SET DEFAULT nextval('public.clients_id_client_seq'::regclass);


--
-- Name: contacts id_contact; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id_contact SET DEFAULT nextval('public.contacts_id_contact_seq'::regclass);


--
-- Name: countries id_country; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id_country SET DEFAULT nextval('public.countries_id_country_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: opportunities id_opportunity; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities ALTER COLUMN id_opportunity SET DEFAULT nextval('public.opportunities_id_opportunity_seq'::regclass);


--
-- Name: roles id_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id_role SET DEFAULT nextval('public.roles_id_role_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id_activity, type, description, date_activity, created_at, updated_at) FROM stdin;
1	call	Appel de découverte très positif. Le DSI a validé le budget global.	2026-03-29 22:24:07	2026-04-01 22:24:07	2026-04-01 22:24:07
2	meeting	Réunion sur site pour auditer l'infrastructure réseau actuelle.	2026-03-25 22:24:07	2026-04-01 22:24:07	2026-04-01 22:24:07
3	email	Envoi du devis révisé avec la remise de 10% appliquée.	2026-03-30 22:24:07	2026-04-01 22:24:07	2026-04-01 22:24:07
4	task	Préparer la maquette Figma pour la prochaine présentation.	2026-03-31 22:24:07	2026-04-01 22:24:07	2026-04-01 22:24:07
5	note	Client très exigeant sur les délais, prévoir une marge de sécurité.	2026-03-18 22:24:07	2026-04-01 22:24:07	2026-04-01 22:24:07
\.


--
-- Data for Name: activity_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_client (id_activity_client, activity_id, client_id, created_at, updated_at) FROM stdin;
1	1	1	2026-04-01 22:24:07	2026-04-01 22:24:07
2	2	4	2026-04-01 22:24:07	2026-04-01 22:24:07
3	3	7	2026-04-01 22:24:07	2026-04-01 22:24:07
4	4	3	2026-04-01 22:24:07	2026-04-01 22:24:07
5	5	8	2026-04-01 22:24:07	2026-04-01 22:24:07
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id_address, street, number, postal_code, complement, client_id, city_id, created_at, updated_at) FROM stdin;
1	Avenue des Champs-Élysées	15	75008	Étage 4	1	2	2026-04-01 22:24:07	2026-04-01 22:24:07
2	Rue de la République	42	69002	\N	2	3	2026-04-01 22:24:07	2026-04-01 22:24:07
3	Boulevard des Belges	112	76000	Bâtiment B	3	1	2026-04-01 22:24:07	2026-04-01 22:24:07
4	Avenue de Lille	8	59000	Zone Industrielle	4	5	2026-04-01 22:24:07	2026-04-01 22:24:07
5	Place du Capitole	1	31000	\N	5	9	2026-04-01 22:24:07	2026-04-01 22:24:07
6	Rue de Rennes	89	75006	Tour Défense	6	2	2026-04-01 22:24:07	2026-04-01 22:24:07
7	Vieux Port	14	13001	Bureau 12	7	4	2026-04-01 22:24:07	2026-04-01 22:24:07
8	Rue Jeanne d'Arc	55	76000	\N	8	1	2026-04-01 22:24:07	2026-04-01 22:24:07
9	Avenue de l'Europe	23	67000	Parc Logistique	9	8	2026-04-01 22:24:07	2026-04-01 22:24:07
10	Quai des Chartrons	77	33000	\N	10	6	2026-04-01 22:24:07	2026-04-01 22:24:07
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
laravel-cache-10440ad6b670f7a1a7055ef36a42241e:timer	i:1775067002;	1775067002
laravel-cache-10440ad6b670f7a1a7055ef36a42241e	i:1;	1775067002
laravel-cache-8a2e2afa4312eb8ba0b6159ea9e9c145:timer	i:1775115469;	1775115469
laravel-cache-8a2e2afa4312eb8ba0b6159ea9e9c145	i:1;	1775115469
laravel-cache-admin@crm.fr|127.0.0.1:timer	i:1775115470;	1775115470
laravel-cache-admin@crm.fr|127.0.0.1	i:1;	1775115470
laravel-cache-a77241c23d078cedcacf1a71376b4033:timer	i:1775149962;	1775149962
laravel-cache-a77241c23d078cedcacf1a71376b4033	i:1;	1775149962
laravel-cache-25bc3696bff0bd362eb529397b561c22:timer	i:1775155700;	1775155700
laravel-cache-25bc3696bff0bd362eb529397b561c22	i:1;	1775155700
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cities (id_city, name, country_id, created_at, updated_at) FROM stdin;
1	Rouen	1	2026-04-01 13:51:27	2026-04-01 13:51:27
2	Paris	1	2026-04-01 13:51:27	2026-04-01 13:51:27
3	Lyon	1	2026-04-01 13:51:27	2026-04-01 13:51:27
4	Marseille	1	2026-04-01 13:51:27	2026-04-01 13:51:27
5	Lille	1	2026-04-01 13:51:27	2026-04-01 13:51:27
6	Bordeaux	1	2026-04-01 13:51:27	2026-04-01 13:51:27
7	Nantes	1	2026-04-01 13:51:27	2026-04-01 13:51:27
8	Strasbourg	1	2026-04-01 13:51:27	2026-04-01 13:51:27
9	Toulouse	1	2026-04-01 13:51:27	2026-04-01 13:51:27
10	Montpellier	1	2026-04-01 13:51:27	2026-04-01 13:51:27
11	Bruxelles	2	2026-04-01 13:51:27	2026-04-01 13:51:27
12	Anvers	2	2026-04-01 13:51:27	2026-04-01 13:51:27
13	Gand	2	2026-04-01 13:51:27	2026-04-01 13:51:27
14	Charleroi	2	2026-04-01 13:51:27	2026-04-01 13:51:27
15	Liège	2	2026-04-01 13:51:27	2026-04-01 13:51:27
16	Bruges	2	2026-04-01 13:51:27	2026-04-01 13:51:27
17	Namur	2	2026-04-01 13:51:27	2026-04-01 13:51:27
18	Louvain	2	2026-04-01 13:51:27	2026-04-01 13:51:27
19	Mons	2	2026-04-01 13:51:27	2026-04-01 13:51:27
20	Malines	2	2026-04-01 13:51:27	2026-04-01 13:51:27
21	Alost	2	2026-04-01 13:51:27	2026-04-01 13:51:27
22	La Louvière	2	2026-04-01 13:51:27	2026-04-01 13:51:27
23	Hasselt	2	2026-04-01 13:51:27	2026-04-01 13:51:27
24	Courtrai	2	2026-04-01 13:51:27	2026-04-01 13:51:27
25	Tournai	2	2026-04-01 13:51:27	2026-04-01 13:51:27
26	Seraing	2	2026-04-01 13:51:27	2026-04-01 13:51:27
27	Verviers	2	2026-04-01 13:51:27	2026-04-01 13:51:27
28	Mouscron	2	2026-04-01 13:51:27	2026-04-01 13:51:27
29	Braine-l'Alleud	2	2026-04-01 13:51:27	2026-04-01 13:51:27
30	Wavre	2	2026-04-01 13:51:27	2026-04-01 13:51:27
31	Genève	3	2026-04-01 13:51:27	2026-04-01 13:51:27
32	Zurich	3	2026-04-01 13:51:27	2026-04-01 13:51:27
33	Lausanne	3	2026-04-01 13:51:27	2026-04-01 13:51:27
34	Berne	3	2026-04-01 13:51:27	2026-04-01 13:51:27
35	Bâle	3	2026-04-01 13:51:27	2026-04-01 13:51:27
36	Berlin	6	2026-04-01 13:51:27	2026-04-01 13:51:27
37	Munich	6	2026-04-01 13:51:27	2026-04-01 13:51:27
38	Hambourg	6	2026-04-01 13:51:27	2026-04-01 13:51:27
39	Francfort	6	2026-04-01 13:51:27	2026-04-01 13:51:27
40	Cologne	6	2026-04-01 13:51:27	2026-04-01 13:51:27
41	Luxembourg-Ville	4	2026-04-01 13:51:27	2026-04-01 13:51:27
42	Esch-sur-Alzette	4	2026-04-01 13:51:27	2026-04-01 13:51:27
43	Differdange	4	2026-04-01 13:51:27	2026-04-01 13:51:27
44	Dudelange	4	2026-04-01 13:51:27	2026-04-01 13:51:27
45	Montréal	5	2026-04-01 13:51:27	2026-04-01 13:51:27
46	Québec	5	2026-04-01 13:51:27	2026-04-01 13:51:27
47	Toronto	5	2026-04-01 13:51:27	2026-04-01 13:51:27
48	Ottawa	5	2026-04-01 13:51:27	2026-04-01 13:51:27
49	Vancouver	5	2026-04-01 13:51:27	2026-04-01 13:51:27
50	Madrid	7	2026-04-01 13:51:27	2026-04-01 13:51:27
51	Barcelone	7	2026-04-01 13:51:27	2026-04-01 13:51:27
52	Valence	7	2026-04-01 13:51:27	2026-04-01 13:51:27
53	Séville	7	2026-04-01 13:51:27	2026-04-01 13:51:27
54	Bilbao	7	2026-04-01 13:51:27	2026-04-01 13:51:27
55	Rome	8	2026-04-01 13:51:27	2026-04-01 13:51:27
56	Milan	8	2026-04-01 13:51:27	2026-04-01 13:51:27
57	Naples	8	2026-04-01 13:51:27	2026-04-01 13:51:27
58	Turin	8	2026-04-01 13:51:27	2026-04-01 13:51:27
59	Florence	8	2026-04-01 13:51:27	2026-04-01 13:51:27
60	Londres	9	2026-04-01 13:51:27	2026-04-01 13:51:27
61	Manchester	9	2026-04-01 13:51:27	2026-04-01 13:51:27
62	Birmingham	9	2026-04-01 13:51:27	2026-04-01 13:51:27
63	Édimbourg	9	2026-04-01 13:51:27	2026-04-01 13:51:27
64	Glasgow	9	2026-04-01 13:51:27	2026-04-01 13:51:27
65	New York	10	2026-04-01 13:51:27	2026-04-01 13:51:27
66	Los Angeles	10	2026-04-01 13:51:27	2026-04-01 13:51:27
67	Chicago	10	2026-04-01 13:51:27	2026-04-01 13:51:27
68	Miami	10	2026-04-01 13:51:27	2026-04-01 13:51:27
69	San Francisco	10	2026-04-01 13:51:27	2026-04-01 13:51:27
\.


--
-- Data for Name: client_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user (id_client_user, user_id, client_id, is_primary, created_at, updated_at) FROM stdin;
1	3	1	t	2026-04-01 22:24:07	2026-04-01 22:24:07
2	4	1	f	2026-04-01 22:24:07	2026-04-01 22:24:07
3	4	2	t	2026-04-01 22:24:07	2026-04-01 22:24:07
4	5	3	t	2026-04-01 22:24:07	2026-04-01 22:24:07
6	3	4	f	2026-04-01 22:24:07	2026-04-01 22:24:07
7	3	5	t	2026-04-01 22:24:07	2026-04-01 22:24:07
8	4	6	t	2026-04-01 22:24:07	2026-04-01 22:24:07
9	5	7	t	2026-04-01 22:24:07	2026-04-01 22:24:07
12	3	9	t	2026-04-01 22:24:07	2026-04-01 22:24:07
13	4	10	t	2026-04-01 22:24:07	2026-04-01 22:24:07
14	3	11	t	2026-04-02 14:41:06	2026-04-02 14:41:06
15	3	12	t	2026-04-02 14:52:20	2026-04-02 14:52:20
16	3	13	t	2026-04-02 16:19:04	2026-04-02 16:19:04
17	3	14	t	2026-04-02 16:20:01	2026-04-02 16:20:01
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id_client, company_name, email, phone, website, income, created_at, updated_at) FROM stdin;
1	TechSolutions SAS	contact@techsolutions.fr	01 45 67 89 00	https://www.techsolutions.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
2	Groupe Horizon	hello@groupe-horizon.com	04 78 90 12 34	https://www.groupe-horizon.com	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
3	Atelier Digital	bonjour@atelier-digital.fr	02 35 46 78 90	https://www.atelier-digital.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
4	Logistique Express	contact@logistique-express.fr	03 20 56 78 91	https://www.logistique-express.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
5	InnovSanté	direction@innovsante.fr	05 61 23 45 67	https://www.innovsante.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
6	CyberDéfense Pro	audit@cyberdefense-pro.fr	01 56 78 90 12	https://www.cyberdefense-pro.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
7	Énergies Demain	contact@energies-demain.fr	04 91 23 45 67	https://www.energies-demain.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
8	Banque Populaire Normande	si@bp-normande.fr	02 32 45 67 89	https://www.bp-normande.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
9	AgroAlimentaire Distribution	achats@agro-distrib.fr	03 88 90 12 34	https://www.agro-distrib.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
10	Construction Moderne	projets@construction-moderne.fr	05 56 78 90 12	https://www.construction-moderne.fr	\N	2026-04-01 22:24:07	2026-04-01 22:24:07
11	Google	google@gmail.com	01 01 01 01 01 01	https://google.com	\N	2026-04-02 14:41:06	2026-04-02 14:41:06
12	Facebook	facebook@gmail.com	02 02 02 02 02	https://facebook.com	60000	2026-04-02 14:52:20	2026-04-02 14:52:20
13	Linkedin	linkedin@gmail.com	03 03 03 03 03	https://linkedin.com	1029304	2026-04-02 16:19:04	2026-04-02 16:19:04
14	Opera	opera@gmail.com	04 04 04 04 04	https://opera.com	1084115	2026-04-02 16:20:01	2026-04-02 16:20:01
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id_contact, first_name, last_name, email, phone, type, description, client_id, created_at, updated_at) FROM stdin;
1	Jean-Marc	Dupont	jm.dupont@techsolutions.fr	06 12 34 56 78	customer	DSI (Directeur des Systèmes d'Information)	1	2026-04-01 22:24:07	2026-04-01 22:24:07
2	Alice	Tremblay	a.tremblay@techsolutions.fr	06 98 76 54 32	partner	Responsable Achat IT	1	2026-04-01 22:24:07	2026-04-01 22:24:07
3	Paul	Boucher	pboucher@groupe-horizon.com	07 11 22 33 44	customer	PDG	2	2026-04-01 22:24:07	2026-04-01 22:24:07
4	Claire	Lefevre	c.lefevre@atelier-digital.fr	06 55 44 33 22	lead	Chef de Projet Digital	3	2026-04-01 22:24:07	2026-04-01 22:24:07
5	Marc	Rousseau	m.rousseau@logistique-express.fr	07 66 77 88 99	customer	Directeur Logistique	4	2026-04-01 22:24:07	2026-04-01 22:24:07
6	Sylvie	Moreau	s.moreau@innovsante.fr	06 99 88 77 66	prospect	Directrice Innovation	5	2026-04-01 22:24:07	2026-04-01 22:24:07
7	Luc	Fournier	l.fournier@innovsante.fr	07 12 13 14 15	partner	Chargé de Recherche	5	2026-04-01 22:24:07	2026-04-01 22:24:07
8	Antoine	Girard	a.girard@cyberdefense-pro.fr	06 23 34 45 56	customer	Expert Sécurité	6	2026-04-01 22:24:07	2026-04-01 22:24:07
9	Marie	Blanc	m.blanc@energies-demain.fr	07 34 45 56 67	lead	Responsable RSE	7	2026-04-01 22:24:07	2026-04-01 22:24:07
10	Pierre	Gauthier	p.gauthier@bp-normande.fr	06 45 56 67 78	customer	Responsable Infrastructures	8	2026-04-01 22:24:07	2026-04-01 22:24:07
11	Julie	Perrin	j.perrin@agro-distrib.fr	07 56 67 78 89	prospect	Directrice Commerciale	9	2026-04-01 22:24:07	2026-04-01 22:24:07
12	François	Richard	f.richard@construction-moderne.fr	06 67 78 89 90	customer	Chef de Chantier	10	2026-04-01 22:24:07	2026-04-01 22:24:07
13	Maxence	Saint-Sans	theo@sagnier.com	06 06 07 08 09	partner	Git Master	1	2026-04-02 10:00:56	2026-04-02 10:00:56
14	Mark	Zuckerberg	mark.zucker@gmail.com	02 03 02 03 02 03	lead	CEO	12	2026-04-02 14:52:20	2026-04-02 14:52:20
15	Opera	Leclerc	opera.leclerc@gmail.com	04 03 04 04 04	partner	CEO	14	2026-04-02 16:20:01	2026-04-02 16:20:01
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id_country, name, created_at, updated_at) FROM stdin;
1	France	2026-04-01 13:51:26	2026-04-01 13:51:26
2	Belgique	2026-04-01 13:51:26	2026-04-01 13:51:26
3	Suisse	2026-04-01 13:51:26	2026-04-01 13:51:26
4	Luxembourg	2026-04-01 13:51:26	2026-04-01 13:51:26
5	Canada	2026-04-01 13:51:26	2026-04-01 13:51:26
6	Allemagne	2026-04-01 13:51:26	2026-04-01 13:51:26
7	Espagne	2026-04-01 13:51:26	2026-04-01 13:51:26
8	Italie	2026-04-01 13:51:26	2026-04-01 13:51:26
9	Royaume-Uni	2026-04-01 13:51:26	2026-04-01 13:51:26
10	États-Unis	2026-04-01 13:51:26	2026-04-01 13:51:26
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
15	0001_01_01_000000_create_roles_table	1
16	0001_01_01_000000_create_users_table	1
17	0001_01_01_000001_create_cache_table	1
18	0001_01_01_000002_create_jobs_table	1
19	2025_08_14_170933_add_two_factor_columns_to_users_table	1
20	2026_01_01_000000_create_countries_table	1
21	2026_01_01_000001_create_cities_table	1
22	2026_01_01_000003_create_clients_table	1
23	2026_01_01_000004_create_addresses_table	1
24	2026_01_01_000005_create_activities_table	1
25	2026_01_01_000005_create_contacts_table	1
26	2026_01_01_000005_create_opportunities_table	1
27	2026_01_01_000006_create_activity_client_table	1
28	2026_01_01_000006_create_client_user_table	1
\.


--
-- Data for Name: opportunities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.opportunities (id_opportunity, source, details, status, type, amount, closed_date, client_id, created_at, updated_at) FROM stdin;
2	Appel à froid	Contrat de maintenance annuelle des serveurs	negotiation	renewal	12000.00	2026-05-01 22:24:07	1	2026-04-01 22:24:07	2026-04-01 22:24:07
3	LinkedIn	Déploiement fibre optique multisites	closed_won	new_business	45500.00	2025-12-01 22:24:07	2	2026-04-01 22:24:07	2026-04-01 22:24:07
4	Recommandation	Création d'une application mobile iOS/Android	proposal	new_business	38000.00	2026-06-01 22:24:07	3	2026-04-01 22:24:07	2026-04-01 22:24:07
5	Salon Pro	Mise en place d'un ERP Logistique	closed_won	new_business	85000.00	2026-03-01 22:24:07	4	2026-04-01 22:24:07	2026-04-01 22:24:07
6	Site Web	Ajout du module IA sur l'application existante	qualification	upsell	15000.00	2026-07-01 22:24:07	4	2026-04-01 22:24:07	2026-04-01 22:24:07
7	Appel à froid	Audit complet de cybersécurité	closed_lost	new_business	9500.00	2025-11-01 22:24:07	5	2026-04-01 22:24:07	2026-04-01 22:24:07
8	LinkedIn	Formation des équipes aux bonnes pratiques RGPD	closed_won	upsell	4000.00	2026-03-22 22:24:07	6	2026-04-01 22:24:07	2026-04-01 22:24:07
9	Recommandation	Migration vers une infrastructure Cloud AWS	negotiation	new_business	60000.00	2026-04-16 22:24:07	7	2026-04-01 22:24:07	2026-04-01 22:24:07
10	Site Web	Développement du portail client bancaire	closed_won	new_business	120000.00	2025-10-01 22:24:07	8	2026-04-01 22:24:07	2026-04-01 22:24:07
11	Salon Pro	Renouvellement des licences logicielles	proposal	renewal	8000.00	2026-05-01 22:24:07	9	2026-04-01 22:24:07	2026-04-01 22:24:07
12	Appel à froid	Outil de suivi de chantier sur tablette	qualification	new_business	22000.00	2026-08-01 22:24:07	10	2026-04-01 22:24:07	2026-04-01 22:24:07
13	Site	Refonte complète	proposal	upsell	10000.00	2026-04-04 00:00:00	1	2026-04-02 13:15:16	2026-04-02 13:15:16
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id_role, rolename, created_at, updated_at) FROM stdin;
1	admin	2026-04-01 13:51:26	2026-04-01 13:51:26
2	manager	2026-04-01 13:51:26	2026-04-01 13:51:26
3	sales_rep	2026-04-01 13:51:26	2026-04-01 13:51:26
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
hORv5nw8OFaIfHpiVeAVxEnBkqxkF8ARbgXcbQBE	3	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiclBzUk1xaWlBQklwV3dHcmFkdjlwNXY5MVhINk9EZWM2WWc2WENNSiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MztzOjk6Il9wcmV2aW91cyI7YToyOntzOjM6InVybCI7czo0MToiaHR0cHM6Ly9iaXNjdWl0LnRlc3Q6ODQ0My9jbGllbnRzP3NlYXJjaD0iO3M6NToicm91dGUiO3M6MTM6ImNsaWVudHMuaW5kZXgiO319	1775157506
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, key, value, created_at, updated_at) FROM stdin;
2	support_email	admin@biscuit.test	2026-04-02 20:05:35	2026-04-02 20:05:35
3	currency	EUR	2026-04-02 20:05:35	2026-04-02 20:05:35
1	company_name	Les Vieux Biscuits	2026-04-02 20:05:35	2026-04-02 18:08:19
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_user, name, email, email_verified_at, password, last_login, remember_token, role_id, created_at, updated_at, two_factor_secret, two_factor_recovery_codes, two_factor_confirmed_at) FROM stdin;
5	Thomas Petit	thomas@crm.fr	\N	$2y$12$La84UiY0vHW1m16zeq8R6OxgZsqSj0Q4U.oFoz6nKU64xaxKOc4aS	\N	\N	3	2026-04-01 22:24:06	2026-04-01 22:24:06	\N	\N	\N
1	Directeur Admin	admin1@crm.fr	\N	$2y$12$jroJwnAP8bt7xb4nYWSjseWKDaAY0b4IFEsOn/DR1Z/.URd0P9nUm	\N	\N	1	2026-04-01 22:24:06	2026-04-02 07:29:22	\N	\N	\N
3	Lucas Martin	lucas@crm.fr	\N	$2y$12$Yg2YwUzn/h3y.epT74Jpoev2JmcE8GhXmnTu9hA.aZJdcxNPGGuWe	\N	\N	3	2026-04-01 22:24:06	2026-04-02 07:33:28	\N	\N	\N
2	Support IT Admin	admin2@crm.fr	\N	$2y$12$La84UiY0vHW1m16zeq8R6OxgZsqSj0Q4U.oFoz6nKU64xaxKOc4aS	\N	\N	2	2026-04-01 22:24:06	2026-04-02 17:39:11	\N	\N	\N
4	Sophie Bernard	sophie@crm.fr	\N	$2y$12$La84UiY0vHW1m16zeq8R6OxgZsqSj0Q4U.oFoz6nKU64xaxKOc4aS	\N	\N	1	2026-04-01 22:24:06	2026-04-02 17:39:16	\N	\N	\N
7	Ange Wu	ange@gmail.com	\N	$2y$12$so6gWkh2xKrg82SItmBcyuODmFB.URdMiJsfa/IQ4LvHTknpFg7PO	\N	\N	1	2026-04-02 17:40:26	2026-04-02 17:40:26	\N	\N	\N
\.


--
-- Name: activities_id_activity_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activities_id_activity_seq', 6, true);


--
-- Name: activity_client_id_activity_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_client_id_activity_client_seq', 6, true);


--
-- Name: addresses_id_address_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_address_seq', 10, true);


--
-- Name: cities_id_city_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_city_seq', 69, true);


--
-- Name: client_user_id_client_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_user_id_client_user_seq', 19, true);


--
-- Name: clients_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_client_seq', 14, true);


--
-- Name: contacts_id_contact_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_contact_seq', 15, true);


--
-- Name: countries_id_country_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_country_seq', 10, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 28, true);


--
-- Name: opportunities_id_opportunity_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.opportunities_id_opportunity_seq', 13, true);


--
-- Name: roles_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_role_seq', 3, true);


--
-- Name: settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.settings_id_seq', 3, true);


--
-- Name: users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_user_seq', 7, true);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id_activity);


--
-- Name: activity_client activity_client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_client
    ADD CONSTRAINT activity_client_pkey PRIMARY KEY (id_activity_client);


--
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id_address);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id_city);


--
-- Name: client_user client_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user
    ADD CONSTRAINT client_user_pkey PRIMARY KEY (id_client_user);


--
-- Name: clients clients_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_email_unique UNIQUE (email);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id_client);


--
-- Name: contacts contacts_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_email_unique UNIQUE (email);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id_contact);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id_country);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: opportunities opportunities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities
    ADD CONSTRAINT opportunities_pkey PRIMARY KEY (id_opportunity);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id_role);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: settings settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_key_key UNIQUE (key);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id_user);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: idx_settings_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_settings_key ON public.settings USING btree (key);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: activity_client activity_client_activity_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_client
    ADD CONSTRAINT activity_client_activity_id_foreign FOREIGN KEY (activity_id) REFERENCES public.activities(id_activity) ON DELETE CASCADE;


--
-- Name: activity_client activity_client_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activity_client
    ADD CONSTRAINT activity_client_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id_client) ON DELETE CASCADE;


--
-- Name: addresses addresses_city_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_city_id_foreign FOREIGN KEY (city_id) REFERENCES public.cities(id_city) ON DELETE CASCADE;


--
-- Name: addresses addresses_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id_client) ON DELETE CASCADE;


--
-- Name: cities cities_country_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_country_id_foreign FOREIGN KEY (country_id) REFERENCES public.countries(id_country) ON DELETE CASCADE;


--
-- Name: client_user client_user_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user
    ADD CONSTRAINT client_user_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id_client) ON DELETE CASCADE;


--
-- Name: client_user client_user_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user
    ADD CONSTRAINT client_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id_user) ON DELETE CASCADE;


--
-- Name: contacts contacts_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id_client) ON DELETE CASCADE;


--
-- Name: opportunities opportunities_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.opportunities
    ADD CONSTRAINT opportunities_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id_client) ON DELETE CASCADE;


--
-- Name: users users_role_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_foreign FOREIGN KEY (role_id) REFERENCES public.roles(id_role);


--
-- PostgreSQL database dump complete
--

\unrestrict ufz0dyQ8tCgcU9vo19faOgnncTguq2fwIATif73Qfw98a3gMPZ6qtXctBUYSQf3

