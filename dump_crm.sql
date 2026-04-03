--
-- PostgreSQL database dump
--

\restrict uJoXMuuUoQbZEtC8EN4pnnM1OEIY43NCBlOGddnYSUWQwXBjKppOHa0JKELF3Ts

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
-- Name: users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id_user SET DEFAULT nextval('public.users_id_user_seq'::regclass);


--
-- Data for Name: activities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activities (id_activity, type, description, date_activity, created_at, updated_at) FROM stdin;
1	call	Enim omnis quia eos et consequatur dolorem autem ullam amet.	2026-03-03 01:06:43	2026-04-01 13:51:32	2026-04-01 13:51:32
2	email	Nobis qui qui labore deserunt dolores omnis id dolorem doloribus hic sed necessitatibus.	2026-04-12 13:17:26	2026-04-01 13:51:32	2026-04-01 13:51:32
3	meeting	Possimus est numquam ut soluta rerum odit perspiciatis.	2026-04-18 08:03:39	2026-04-01 13:51:32	2026-04-01 13:51:32
4	task	Odio deleniti facere quam explicabo porro animi porro consequatur.	2026-03-02 07:17:38	2026-04-01 13:51:32	2026-04-01 13:51:32
5	note	Eum dolor hic iste et doloremque ipsam enim perspiciatis quia est sed ipsa eveniet.	2026-03-03 06:06:32	2026-04-01 13:51:32	2026-04-01 13:51:32
\.


--
-- Data for Name: activity_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activity_client (id_activity_client, activity_id, client_id, created_at, updated_at) FROM stdin;
3	2	11	\N	\N
5	3	15	\N	\N
6	3	12	\N	\N
7	4	3	\N	\N
8	4	19	\N	\N
10	5	7	\N	\N
1	1	1	\N	\N
2	1	7	\N	\N
4	2	1	\N	\N
9	5	1	\N	\N
\.


--
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.addresses (id_address, street, number, postal_code, complement, client_id, city_id, created_at, updated_at) FROM stdin;
1	149 Emilie Avenue	158	17751-1011	8789	1	8	2026-04-01 13:51:32	2026-04-01 13:51:32
2	7253 Raven Junctions Suite 594	250	21467-9233	45854	2	21	2026-04-01 13:51:32	2026-04-01 13:51:32
3	9018 Auer Shores Apt. 714	149	38426-8075	9207	3	2	2026-04-01 13:51:32	2026-04-01 13:51:32
4	22010 Abernathy Rue Suite 219	207	55489-5072	90867	4	35	2026-04-01 13:51:32	2026-04-01 13:51:32
5	5056 Beahan Circle Suite 857	124	82844	97630	5	66	2026-04-01 13:51:32	2026-04-01 13:51:32
6	1471 Susana Dam	46	78192-5390	7889	6	20	2026-04-01 13:51:32	2026-04-01 13:51:32
7	2667 Fadel Isle Suite 158	262	45953	8790	7	50	2026-04-01 13:51:32	2026-04-01 13:51:32
8	30677 Nellie Lodge Apt. 776	185	54568	66470	8	18	2026-04-01 13:51:32	2026-04-01 13:51:32
9	114 Unique Villages Suite 736	22	29012-5249	7371	9	35	2026-04-01 13:51:32	2026-04-01 13:51:32
10	25522 Malachi Shores	258	34500-6787	437	10	39	2026-04-01 13:51:32	2026-04-01 13:51:32
11	7449 Herzog Light	212	34639-5953	744	11	28	2026-04-01 13:51:32	2026-04-01 13:51:32
12	19366 Ernser Motorway Apt. 961	65	24437	14754	12	65	2026-04-01 13:51:32	2026-04-01 13:51:32
13	8203 Johnson Loop Apt. 255	155	48741-3064	710	13	58	2026-04-01 13:51:32	2026-04-01 13:51:32
14	7534 Alyce Streets	158	61839	94925	14	14	2026-04-01 13:51:32	2026-04-01 13:51:32
15	3163 Harris Lodge Apt. 089	241	15159	6833	15	54	2026-04-01 13:51:32	2026-04-01 13:51:32
16	284 Fay Mountains Suite 852	295	87027	14032	16	22	2026-04-01 13:51:32	2026-04-01 13:51:32
17	3791 Sandrine Rest	206	44136-9807	95046	17	3	2026-04-01 13:51:32	2026-04-01 13:51:32
18	22397 Murray Plains	52	81757-5898	5398	18	59	2026-04-01 13:51:32	2026-04-01 13:51:32
19	3311 Theresia Ranch Suite 920	46	32774-1754	20939	19	60	2026-04-01 13:51:32	2026-04-01 13:51:32
20	31879 Percy Rapid	223	08636	8592	20	53	2026-04-01 13:51:32	2026-04-01 13:51:32
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
laravel-cache-10440ad6b670f7a1a7055ef36a42241e:timer	i:1775067002;	1775067002
laravel-cache-10440ad6b670f7a1a7055ef36a42241e	i:1;	1775067002
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
2	3	1	t	2026-04-01 13:51:31	2026-04-01 13:51:31
6	5	5	t	2026-04-01 13:51:31	2026-04-01 13:51:31
7	4	6	t	2026-04-01 13:51:31	2026-04-01 13:51:31
9	5	7	t	2026-04-01 13:51:31	2026-04-01 13:51:31
11	1	8	t	2026-04-01 13:51:31	2026-04-01 13:51:31
12	1	9	t	2026-04-01 13:51:31	2026-04-01 13:51:31
14	3	10	t	2026-04-01 13:51:31	2026-04-01 13:51:31
15	3	11	t	2026-04-01 13:51:31	2026-04-01 13:51:31
17	4	12	t	2026-04-01 13:51:31	2026-04-01 13:51:31
18	2	13	t	2026-04-01 13:51:31	2026-04-01 13:51:31
20	2	14	t	2026-04-01 13:51:31	2026-04-01 13:51:31
22	5	15	t	2026-04-01 13:51:32	2026-04-01 13:51:32
23	2	16	t	2026-04-01 13:51:32	2026-04-01 13:51:32
24	4	17	t	2026-04-01 13:51:32	2026-04-01 13:51:32
26	6	18	t	2026-04-01 13:51:32	2026-04-01 13:51:32
28	6	19	t	2026-04-01 13:51:32	2026-04-01 13:51:32
29	4	20	t	2026-04-01 13:51:32	2026-04-01 13:51:32
3	7	2	t	2026-04-01 13:51:31	2026-04-01 13:51:31
5	7	4	t	2026-04-01 13:51:31	2026-04-01 13:51:31
4	7	3	t	2026-04-01 13:51:31	2026-04-01 13:51:31
27	1	19	f	2026-04-01 13:51:32	2026-04-01 13:51:32
25	4	18	f	2026-04-01 13:51:32	2026-04-01 13:51:32
21	2	15	f	2026-04-01 13:51:32	2026-04-01 13:51:32
19	5	14	f	2026-04-01 13:51:31	2026-04-01 13:51:31
16	3	12	f	2026-04-01 13:51:31	2026-04-01 13:51:31
13	1	10	f	2026-04-01 13:51:31	2026-04-01 13:51:31
10	5	8	f	2026-04-01 13:51:31	2026-04-01 13:51:31
8	2	6	f	2026-04-01 13:51:31	2026-04-01 13:51:31
1	7	1	f	2026-04-01 13:51:31	2026-04-01 13:51:31
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id_client, company_name, email, phone, website, income, created_at, updated_at) FROM stdin;
1	Blanda Group	gfay@hills.com	1-254-518-4203	https://www.blanda-group.com	\N	2026-04-01 11:11:00	2026-04-01 13:51:31
2	Kling-Cronin	wcollins@beatty.info	+1 (281) 660-3487	https://www.kling-cronin.com	\N	2025-10-16 12:10:09	2026-04-01 13:51:31
3	Runolfsdottir, Wuckert and King	aidan.vandervort@ritchie.com	1-254-345-5186	https://www.runolfsdottir,-wuckert-and-king.com	\N	2026-02-09 20:12:34	2026-04-01 13:51:31
4	Rosenbaum Group	koepp.mariane@oconnell.net	+1-667-737-0275	https://www.rosenbaum-group.com	\N	2025-12-29 11:40:13	2026-04-01 13:51:31
5	Green, Runte and Bahringer	schinner.johnathon@runte.net	+14192096685	https://www.green,-runte-and-bahringer.com	\N	2026-03-01 06:02:55	2026-04-01 13:51:31
6	Schroeder, Barton and Stokes	yokuneva@quitzon.com	1-872-994-3641	https://www.schroeder,-barton-and-stokes.com	\N	2026-01-26 12:17:43	2026-04-01 13:51:31
7	Hickle, Durgan and Howell	darwin.langosh@purdy.com	(415) 376-5361	https://www.hickle,-durgan-and-howell.com	\N	2025-11-08 14:45:55	2026-04-01 13:51:31
8	Abbott Inc	bins.gregoria@parker.info	+16899283658	https://www.abbott-inc.com	\N	2026-02-06 06:18:24	2026-04-01 13:51:31
9	Bergnaum, Watsica and Toy	sophie.watsica@balistreri.com	1-680-344-8110	https://www.bergnaum,-watsica-and-toy.com	\N	2026-02-02 12:00:43	2026-04-01 13:51:31
10	Spencer Inc	cruickshank.sim@fahey.com	346-736-5919	https://www.spencer-inc.com	\N	2025-11-04 14:38:37	2026-04-01 13:51:31
11	Moore, Shields and Sipes	haag.lurline@rowe.com	+1.669.546.0724	https://www.moore,-shields-and-sipes.com	\N	2026-01-03 09:21:51	2026-04-01 13:51:31
12	Stoltenberg-Will	larue.wuckert@schoen.net	(240) 544-5448	https://www.stoltenberg-will.com	\N	2026-01-13 06:29:56	2026-04-01 13:51:31
13	Shields LLC	urogahn@schuster.info	+1.906.761.4220	https://www.shields-llc.com	\N	2026-02-19 07:24:17	2026-04-01 13:51:31
14	Trantow, Johns and Fay	hwalsh@reinger.com	(309) 368-4178	https://www.trantow,-johns-and-fay.com	\N	2025-11-12 06:26:13	2026-04-01 13:51:31
15	D'Amore-Kovacek	mitchell.addie@bergnaum.biz	+1.856.278.6320	https://www.d'amore-kovacek.com	\N	2026-03-17 01:28:44	2026-04-01 13:51:32
16	Spencer, Satterfield and Botsford	clyde87@weissnat.com	+1 (283) 547-0314	https://www.spencer,-satterfield-and-botsford.com	\N	2025-12-15 12:06:50	2026-04-01 13:51:32
17	Larson Inc	jgusikowski@hegmann.org	+1 (361) 642-6734	https://www.larson-inc.com	\N	2026-01-25 08:34:37	2026-04-01 13:51:32
18	Sauer-Lang	mohamed.gulgowski@schowalter.com	1-231-402-6539	https://www.sauer-lang.com	\N	2026-01-10 07:26:03	2026-04-01 13:51:32
19	Volkman-Smith	randy51@leannon.biz	+1-352-691-8003	https://www.volkman-smith.com	\N	2025-10-17 06:56:07	2026-04-01 13:51:32
20	Eichmann PLC	camila.kunde@parisian.net	(986) 361-9580	https://www.eichmann-plc.com	\N	2026-03-26 09:13:32	2026-04-01 13:51:32
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id_contact, first_name, last_name, email, phone, type, description, client_id, created_at, updated_at) FROM stdin;
1	Violette	Jacobs	christiansen.ayden@example.org	708-975-2553	prospect	Voluptatum rerum quod unde libero aperiam labore aut. Sunt aut deserunt repudiandae.	1	2026-04-01 13:51:32	2026-04-01 13:51:32
2	Emelia	Satterfield	modesta.mccullough@example.net	1-929-795-6559	partner	Autem aut provident et quis sit necessitatibus. Sed temporibus sequi velit ab magnam ex. Mollitia voluptatibus deserunt animi cupiditate quae. In ipsa commodi pariatur et ipsa unde vel.	1	2026-04-01 13:51:32	2026-04-01 13:51:32
3	Antonette	Pagac	albertha.goldner@example.com	+1.301.770.9549	prospect	Quia assumenda et vitae eum. A omnis aut et quasi fuga a.	1	2026-04-01 13:51:32	2026-04-01 13:51:32
4	Jensen	Rau	alanis83@example.net	828-724-1084	customer	Eius quos enim libero mollitia. Aperiam molestias ad qui. Nesciunt incidunt provident voluptatem adipisci nisi velit aliquid. Vel deserunt perspiciatis ut voluptatem.	2	2026-04-01 13:51:32	2026-04-01 13:51:32
5	Ashly	Bednar	zechariah36@example.com	740.690.6721	partner	Laborum quia aliquam voluptatum dolor at. Nisi nostrum non odit possimus porro. Debitis iusto aliquam quae voluptas voluptatem dolorum. Atque et enim dolorem est est saepe iste.	2	2026-04-01 13:51:32	2026-04-01 13:51:32
6	Margaret	Willms	kathlyn.franecki@example.net	+1.607.484.2366	lead	Est et saepe deserunt in. Quo reiciendis dolor quisquam.	3	2026-04-01 13:51:32	2026-04-01 13:51:32
7	Jeramy	Price	odessa84@example.org	+1-248-876-6859	partner	Voluptatem omnis consequatur enim asperiores. Dicta voluptatem quia iste occaecati. Ea quis eveniet in blanditiis.	3	2026-04-01 13:51:32	2026-04-01 13:51:32
8	Baylee	Cronin	lorine99@example.org	323-282-1071	customer	Velit numquam accusantium veniam sit voluptatem fuga. Vero quis suscipit architecto consequatur ipsam quis qui rerum. Non nulla illo explicabo autem ducimus quia. Corporis eius deleniti quia eligendi nihil id rerum. Blanditiis doloremque eius qui ut explicabo dicta.	3	2026-04-01 13:51:32	2026-04-01 13:51:32
9	Isobel	Bogan	ohara.cassie@example.net	(361) 586-9702	partner	Tempore rerum voluptates at nihil expedita alias qui itaque. Id quas et perferendis iure. Excepturi cumque optio suscipit quis.	4	2026-04-01 13:51:32	2026-04-01 13:51:32
10	Muriel	Trantow	stevie13@example.org	(956) 809-3318	prospect	Ut qui illo repellat harum culpa. Sint ea voluptas quo aut eos ratione reiciendis. Ullam consequatur architecto ut placeat sunt. Ut occaecati eligendi similique doloremque quia adipisci.	4	2026-04-01 13:51:32	2026-04-01 13:51:32
11	Chadrick	Stiedemann	ward.reynold@example.com	1-947-657-0246	prospect	Hic et error dolores eveniet autem nesciunt. Dignissimos et autem alias debitis magnam aliquid sint architecto. Voluptatem ut aut id.	5	2026-04-01 13:51:32	2026-04-01 13:51:32
12	Tevin	Hackett	jason.doyle@example.net	+1.323.577.5519	partner	Temporibus aut vel alias ipsa. Quo quisquam qui commodi quo id error at. Qui rerum molestias sequi non cupiditate assumenda.	6	2026-04-01 13:51:32	2026-04-01 13:51:32
13	Lafayette	Hackett	block.deven@example.org	941.610.2191	partner	Commodi debitis omnis enim molestias voluptatem aspernatur repellendus. Pariatur molestiae corrupti quia neque qui. Sit non sequi dolor maxime asperiores et adipisci natus. Nam quaerat exercitationem aperiam.	7	2026-04-01 13:51:32	2026-04-01 13:51:32
14	Ceasar	Thiel	felton31@example.com	(540) 290-5807	prospect	Quis possimus fugit et quia assumenda quidem in est. Vel officiis illo nostrum officiis sunt. Quasi minima magni sint facere itaque repellat facilis. Voluptas quia aliquid earum ut aliquam nemo dolorem dignissimos.	7	2026-04-01 13:51:32	2026-04-01 13:51:32
15	Jena	Bednar	cwehner@example.com	267.728.4848	prospect	Provident ad nisi veniam ab sed. Et vel sit necessitatibus ut commodi qui et. Ipsa ut labore aspernatur.	8	2026-04-01 13:51:32	2026-04-01 13:51:32
16	Jan	O'Kon	hyatt.savanna@example.org	564-947-2110	partner	Quod vel et iste. Sint modi sed nesciunt quia laudantium sunt consequuntur natus. Rerum ullam pariatur qui asperiores nesciunt et omnis.	8	2026-04-01 13:51:32	2026-04-01 13:51:32
17	Hettie	Jenkins	lester67@example.com	757-573-7311	lead	Sint iure eligendi iure sapiente. Voluptas soluta maxime quos ab et quis itaque. Quis commodi sit est veniam reprehenderit atque.	9	2026-04-01 13:51:32	2026-04-01 13:51:32
18	Josh	Schaden	hodkiewicz.cecilia@example.net	+1.534.538.1225	prospect	Eius neque molestias veritatis quo. Sit est aut illo vel ipsa eius ut. Dolorem qui necessitatibus ut sit provident nam maiores dolor.	9	2026-04-01 13:51:32	2026-04-01 13:51:32
19	August	Osinski	inienow@example.com	1-660-456-1094	prospect	Nam et sed deleniti est consequuntur. Non corrupti ab et cum voluptate. Qui illo voluptatibus quo delectus atque sunt ut. Nihil totam inventore eum est.	9	2026-04-01 13:51:32	2026-04-01 13:51:32
20	Brody	Bogan	wyman.antonietta@example.com	+14638527363	partner	Quis architecto natus qui officiis. Consequatur esse ipsa reprehenderit quisquam. Saepe modi quaerat vel impedit qui. Aut provident aut facilis facilis amet.	10	2026-04-01 13:51:32	2026-04-01 13:51:32
21	Brisa	Olson	wellington.langosh@example.com	952.365.1372	partner	Iste possimus quae voluptas labore iste. Molestiae sit voluptatem rerum sapiente molestias. Dolore et aspernatur dolores aut.	11	2026-04-01 13:51:32	2026-04-01 13:51:32
22	Angel	Hyatt	hershel59@example.net	+1-434-247-0820	customer	Veniam eos eaque excepturi sit. Aut quas odio ad illum perferendis qui. Tempore dicta odit ea omnis repellat repellat eligendi.	11	2026-04-01 13:51:32	2026-04-01 13:51:32
23	Tristian	Beier	parisian.bennie@example.com	(831) 714-5345	prospect	Ad omnis omnis cum ad. Et explicabo ut omnis sunt reprehenderit nihil non. Autem qui minima non ut qui mollitia ut. Consequuntur corrupti ducimus iure illum sapiente qui vero.	12	2026-04-01 13:51:32	2026-04-01 13:51:32
24	Enola	Schimmel	sammie.gottlieb@example.org	283-530-5866	prospect	Ut sunt iure omnis delectus debitis ipsum vel non. Quos in occaecati quo non adipisci nemo. Occaecati rerum ipsam nemo impedit repudiandae. Dolor aut optio et.	12	2026-04-01 13:51:32	2026-04-01 13:51:32
25	Raymundo	Green	delbert.brekke@example.org	+18583302957	prospect	Sed quisquam autem amet consequuntur esse ipsa enim. Esse excepturi quis expedita qui possimus et sed. Asperiores blanditiis officiis dolore repellendus placeat ut qui. Libero et culpa sint labore vitae tempore.	12	2026-04-01 13:51:32	2026-04-01 13:51:32
26	Erin	Buckridge	kali.stehr@example.net	820-598-1645	lead	Repellat et a adipisci est quis facere dolore eius. Aspernatur dolorem atque quis aut dolorum animi. Laboriosam veniam error ducimus unde.	13	2026-04-01 13:51:32	2026-04-01 13:51:32
27	Norris	Johnson	alford.koepp@example.org	680-666-4617	customer	Aut modi ut fugit repudiandae voluptatem. Quod sint quas magni. Exercitationem veritatis sit labore aut nihil perspiciatis. Quas vel cumque sit quos.	13	2026-04-01 13:51:32	2026-04-01 13:51:32
28	Darrin	Zieme	marcel86@example.com	1-254-342-0844	customer	Officiis consequatur laudantium libero. Qui eveniet laboriosam quam repellendus quia possimus. Tenetur quia quibusdam ut sit ab magnam quod exercitationem. Sed consectetur illo quisquam excepturi qui et voluptatem.	14	2026-04-01 13:51:32	2026-04-01 13:51:32
29	Melyssa	Dietrich	klein.johnpaul@example.org	+1.463.519.3626	partner	Quae adipisci omnis dignissimos debitis tempore nihil. Et aspernatur alias qui. Iste et et illo et omnis ut perspiciatis neque. Sunt et non ullam qui atque perspiciatis a.	15	2026-04-01 13:51:32	2026-04-01 13:51:32
30	Mohammad	Hintz	simonis.diana@example.net	+1-847-293-0672	customer	Numquam magni illo et non cumque voluptas rerum. Nobis omnis ut laborum eligendi voluptate. Et velit et praesentium eligendi nostrum velit.	15	2026-04-01 13:51:32	2026-04-01 13:51:32
31	Evelyn	Mann	brekke.jannie@example.com	+1-503-736-7124	customer	Natus nemo perspiciatis officiis recusandae voluptas. Labore temporibus voluptate dolorem totam in corporis et. Pariatur tempore eveniet et qui non voluptas. Doloremque aut ut laborum id quibusdam cupiditate facere.	16	2026-04-01 13:51:32	2026-04-01 13:51:32
32	Noah	Rogahn	crona.lloyd@example.net	+1-630-847-2001	customer	Asperiores explicabo ut enim qui qui eaque sed. Eveniet et rerum aut impedit et voluptatem et. Placeat suscipit illum quas sint sunt molestiae.	17	2026-04-01 13:51:32	2026-04-01 13:51:32
33	Marques	Ondricka	laron58@example.net	+1-364-852-5632	partner	Nemo est assumenda illo. Dolor omnis odio harum repellendus nesciunt. Quasi consectetur eaque reprehenderit facere qui sed autem.	18	2026-04-01 13:51:32	2026-04-01 13:51:32
34	Laisha	Parisian	effertz.mervin@example.com	(254) 596-7456	customer	Vel possimus officiis quaerat magni sit qui. Sunt fuga vel voluptates voluptatibus ea debitis voluptatem recusandae. Omnis eaque qui consequatur molestiae similique voluptatem et ullam. Laboriosam sit quaerat et non quia.	19	2026-04-01 13:51:32	2026-04-01 13:51:32
35	Gregorio	Wolff	mable.krajcik@example.net	+1 (747) 392-6227	partner	Non occaecati corrupti laudantium adipisci reprehenderit. Consequatur ipsam est culpa et debitis. Voluptas explicabo rerum voluptates numquam explicabo dolorem. Eos dolores nihil enim atque eius consequuntur.	19	2026-04-01 13:51:32	2026-04-01 13:51:32
36	Maxie	White	ycole@example.org	872-772-1126	prospect	Labore voluptas omnis tenetur qui recusandae itaque eos dolore. Qui saepe optio iusto porro voluptatibus. Dolorem aliquid debitis praesentium est voluptas laudantium sed. Eius temporibus aspernatur minus mollitia.	20	2026-04-01 13:51:32	2026-04-01 13:51:32
37	Chet	Hoeger	jan20@example.com	(903) 216-3320	customer	Quo officiis quidem et eum illo assumenda dolores. Totam dolores illum nesciunt sed ut placeat accusantium assumenda. Architecto voluptatem aliquam autem et consequatur dolor.	20	2026-04-01 13:51:32	2026-04-01 13:51:32
38	Cristina	Reilly	erdman.juanita@example.com	248.737.3420	lead	Dolor debitis corrupti voluptatum voluptatem. Velit est doloremque nihil quia. Nemo labore illum magnam et deleniti. Consequatur aperiam quos odit eaque sed sequi eveniet.	20	2026-04-01 13:51:32	2026-04-01 13:51:32
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
1	LinkedIn	Ipsum quae eius rem quod fuga. Quisquam aut quo veritatis pariatur totam in.	closed_lost	upsell	23220.70	2026-04-08 04:48:47	1	2026-04-01 13:51:32	2026-04-01 13:51:32
2	Cold Call	Assumenda porro eum rerum aliquid. At accusamus velit vel. Deserunt delectus molestiae consequatur amet laborum amet vero non.	closed_lost	new_business	9152.00	2026-04-15 14:26:54	1	2026-04-01 13:51:32	2026-04-01 13:51:32
3	Referral	Est ut molestias enim velit ut fugiat odio velit. Ut perferendis voluptates qui fuga nesciunt iure omnis. Perferendis illo tenetur hic.	closed_won	upsell	4973.43	2026-04-07 21:26:21	2	2026-04-01 13:51:32	2026-04-01 13:51:32
4	LinkedIn	Unde necessitatibus error accusamus laboriosam explicabo impedit est. Est modi nihil quos rem autem. Qui voluptas iusto reprehenderit quisquam nesciunt. Architecto quis sunt aut quia nisi eligendi quae hic.	negotiation	upsell	11196.86	2026-04-13 21:21:03	2	2026-04-01 13:51:32	2026-04-01 13:51:32
5	Referral	Perspiciatis consequatur ut asperiores rerum rem consequatur. Nihil impedit rem possimus sapiente ab. Eius consequatur facilis vitae veniam omnis repellendus.	negotiation	new_business	31389.20	2026-08-26 19:05:38	3	2026-04-01 13:51:32	2026-04-01 13:51:32
6	LinkedIn	Quod laborum libero et modi. Assumenda sunt cum officiis architecto ut accusantium. Quae nostrum tenetur aut non quas molestiae suscipit autem. Quo alias in accusamus eaque repellendus.	closed_lost	renewal	36852.46	2026-08-03 06:04:28	3	2026-04-01 13:51:32	2026-04-01 13:51:32
7	LinkedIn	Sit culpa quis corporis. Fugit non voluptas qui voluptas. Nam optio quod doloribus quia. Delectus quos laudantium veniam provident et neque harum. Odit quod quo beatae in illum fugiat quidem esse.	closed_lost	renewal	47449.55	2026-09-27 21:09:31	4	2026-04-01 13:51:32	2026-04-01 13:51:32
8	Referral	Quod molestias velit debitis ad sunt. Non sit et vel corporis et. Enim voluptate repellat id recusandae maiores non enim voluptate.	negotiation	new_business	27327.01	2026-04-30 08:53:36	4	2026-04-01 13:51:32	2026-04-01 13:51:32
9	Website	Aspernatur dicta dicta ipsam libero. Et fugiat quis magni dolores aut. A velit delectus recusandae quidem ea. Aliquam laudantium accusantium sequi omnis consequuntur a ducimus.	qualification	new_business	2871.15	2026-06-06 01:58:44	5	2026-04-01 13:51:32	2026-04-01 13:51:32
10	LinkedIn	Inventore enim explicabo iusto iste magni molestiae. Perspiciatis asperiores sint neque excepturi mollitia beatae. Et ipsum voluptas nam impedit nostrum accusantium.	proposal	new_business	36805.19	2026-08-18 15:41:53	5	2026-04-01 13:51:32	2026-04-01 13:51:32
11	Trade Show	Qui est harum aut saepe aut. Cumque non laudantium temporibus et numquam id iste. Possimus nulla sunt id eos et optio qui et.	closed_won	upsell	13778.83	2026-08-07 15:46:48	6	2026-04-01 13:51:32	2026-04-01 13:51:32
13	Referral	Doloremque aut maxime dicta aut ipsum ipsum est neque. Repellendus optio voluptates soluta expedita. Modi distinctio qui eaque dolorem sed velit. Modi deleniti beatae enim non laborum suscipit.	negotiation	new_business	11971.20	2026-06-07 16:11:17	7	2026-04-01 13:51:32	2026-04-01 13:51:32
14	Referral	Voluptatibus rerum exercitationem consectetur id velit rerum. Quasi similique maxime explicabo error quas suscipit iste. Consequatur autem rerum eos qui. Voluptatem autem similique odit aut sapiente voluptatem ut.	closed_won	upsell	15455.05	2026-06-26 14:21:59	7	2026-04-01 13:51:32	2026-04-01 13:51:32
15	LinkedIn	Eos illum provident quia. Ad rerum sit autem velit minima. Esse sint facere quae voluptatum.	negotiation	upsell	23858.23	2026-05-16 03:22:07	8	2026-04-01 13:51:32	2026-04-01 13:51:32
16	Website	Et nam quo et architecto asperiores sequi necessitatibus cum. Sint minima maxime quibusdam est recusandae. Dolorem facilis nisi vel ut quia ut animi. Soluta autem non praesentium iure id incidunt ut.	closed_lost	new_business	38551.14	2026-06-16 11:26:35	8	2026-04-01 13:51:32	2026-04-01 13:51:32
17	Cold Call	Fugiat id rerum necessitatibus ut. Explicabo accusamus doloremque modi aut. Totam enim saepe amet occaecati. Voluptatibus reprehenderit et molestiae.	closed_won	renewal	32972.46	2026-04-28 09:06:11	9	2026-04-01 13:51:32	2026-04-01 13:51:32
18	Trade Show	Deleniti soluta corrupti officia id quod ut. Explicabo et quos esse est voluptatem consequatur. Dolor dolor et natus minus dolorem repudiandae doloremque.	proposal	renewal	8023.68	2026-05-06 13:31:27	9	2026-04-01 13:51:32	2026-04-01 13:51:32
20	Referral	Atque quis ab maiores harum debitis. Doloribus et sint soluta rerum ullam vel. Sapiente laboriosam hic quaerat alias sapiente tempora.	closed_won	renewal	45209.96	2026-07-25 13:18:58	10	2026-04-01 13:51:32	2026-04-01 13:51:32
21	LinkedIn	Minima aliquid quia reprehenderit ut et qui quis. Quo deserunt tenetur doloremque sint facilis temporibus. Enim est velit sint impedit mollitia.	proposal	renewal	23584.83	2026-09-11 03:47:20	11	2026-04-01 13:51:32	2026-04-01 13:51:32
22	Trade Show	Dolor et et explicabo est et. Aliquam numquam impedit beatae nisi exercitationem. Quis est saepe deleniti sit aut omnis ipsa.	closed_lost	upsell	17062.46	2026-04-16 02:35:18	11	2026-04-01 13:51:32	2026-04-01 13:51:32
23	Referral	Sint nihil exercitationem eius odit hic quasi aspernatur. Impedit quia corrupti est rerum dolorem. Illum amet quo est minus quasi eveniet architecto. Facere excepturi facilis assumenda sint.	closed_won	new_business	30231.04	2026-05-07 00:33:42	12	2026-04-01 13:51:32	2026-04-01 13:51:32
24	Website	Voluptatem omnis sint incidunt aut rerum quia laboriosam dolor. Dicta provident qui non odit. Error totam harum omnis esse reprehenderit adipisci.	qualification	upsell	45518.02	2026-06-18 21:10:24	12	2026-04-01 13:51:32	2026-04-01 13:51:32
25	Website	Perferendis non voluptatem qui itaque. Tempora eos consequuntur vitae consectetur eos repellat. Vitae id quia corporis eius eius in dolorem.	qualification	renewal	30704.25	2026-06-03 05:29:26	13	2026-04-01 13:51:32	2026-04-01 13:51:32
26	Cold Call	Et dicta et sint iure nam nihil. Est aut veritatis ullam est nobis magnam animi sit. Enim dolore rerum nam ullam. Eius delectus nihil voluptatem temporibus nisi sint sequi. Modi voluptate possimus consectetur omnis qui.	proposal	upsell	2090.61	2026-09-27 23:10:29	13	2026-04-01 13:51:32	2026-04-01 13:51:32
27	LinkedIn	Aliquid voluptas hic est doloribus omnis enim. Quia quos aliquid eius praesentium saepe harum accusamus. Debitis perferendis quia reiciendis natus nesciunt dolor.	closed_won	renewal	33716.62	2026-08-08 22:02:38	14	2026-04-01 13:51:32	2026-04-01 13:51:32
28	Website	Maiores dolor eius exercitationem sed quidem. Vitae dolores repudiandae necessitatibus fugit sunt sit. Ad magni molestias dolores earum.	qualification	new_business	14209.55	2026-08-03 02:04:25	14	2026-04-01 13:51:32	2026-04-01 13:51:32
29	Cold Call	Itaque non officia voluptatibus vitae eaque dolorem. Ut assumenda officia sunt repellendus. Dolorum soluta rerum eos sint est aut. Est et nihil ut animi.	proposal	upsell	14907.86	2026-05-02 11:16:51	15	2026-04-01 13:51:32	2026-04-01 13:51:32
30	Referral	Impedit sunt alias aut. Eligendi reprehenderit nam quam ut recusandae corporis nesciunt.	closed_lost	upsell	44075.63	2026-08-12 20:33:21	15	2026-04-01 13:51:32	2026-04-01 13:51:32
12	Website	Tempore et exercitationem ea sed nobis et. Tenetur eveniet deserunt consequuntur corrupti et commodi. Repellendus molestiae et soluta maiores.	qualification	new_business	49195.82	2026-04-14 23:21:48	1	2026-04-01 13:51:32	2026-04-01 13:51:32
31	Referral	Repudiandae exercitationem rerum eveniet est. Earum sit et porro ad animi explicabo est et. Corporis corporis ipsam voluptates ad. Et et eum architecto iusto et doloribus beatae. Voluptates blanditiis eveniet dolorem sapiente aliquid reprehenderit.	closed_lost	new_business	1456.96	2026-06-16 22:39:21	16	2026-04-01 13:51:32	2026-04-01 13:51:32
32	LinkedIn	Consequatur quo ut perspiciatis sunt debitis. In velit ad ut odit et ipsa quos.	proposal	new_business	1607.00	2026-08-21 03:31:26	16	2026-04-01 13:51:32	2026-04-01 13:51:32
33	LinkedIn	Omnis voluptas a corporis qui voluptatem. Nesciunt eveniet molestiae vel ea quis. Aut autem sit quis nisi quia provident voluptatum. Pariatur deserunt autem mollitia molestias consequatur eveniet dolore.	closed_won	renewal	48506.58	2026-06-03 17:55:32	17	2026-04-01 13:51:32	2026-04-01 13:51:32
34	Trade Show	Velit voluptatum veniam sed impedit facilis autem. Quos et ullam dolores.	closed_won	renewal	18758.95	2026-07-05 16:52:31	17	2026-04-01 13:51:32	2026-04-01 13:51:32
35	Website	Mollitia aut minima est aut. Aut non quod magnam inventore. Soluta numquam autem consequuntur et.	proposal	upsell	8878.27	2026-09-02 05:23:36	18	2026-04-01 13:51:32	2026-04-01 13:51:32
36	Cold Call	Est magnam provident eaque nobis eligendi ipsam. Atque maiores debitis ducimus iste. Sit dolorem ut maiores et quaerat sed qui maxime. Ipsam maiores et et incidunt in itaque. Non tempore voluptatem voluptatem inventore.	proposal	new_business	47701.46	2026-09-10 03:58:56	18	2026-04-01 13:51:32	2026-04-01 13:51:32
37	Website	Inventore vero architecto nesciunt dolorem quo ea culpa. Commodi sed iusto eos quia.	negotiation	new_business	49068.81	2026-06-24 21:47:59	19	2026-04-01 13:51:32	2026-04-01 13:51:32
38	Website	Reprehenderit ipsa autem quis et sunt voluptas quod dolores. Accusamus harum facere repudiandae et quo. Eveniet libero doloribus vitae temporibus iure molestias quia non.	proposal	new_business	37655.95	2026-06-16 13:41:10	19	2026-04-01 13:51:32	2026-04-01 13:51:32
39	Referral	Ullam quis nihil doloremque sed. Autem repellat quaerat sit odio consequuntur sequi. Ipsum et deleniti cumque sed enim libero ipsam.	closed_won	renewal	2913.22	2026-05-29 23:31:01	20	2026-04-01 13:51:32	2026-04-01 13:51:32
40	Referral	Praesentium deleniti et ut. Quaerat ad ex excepturi sint eaque sunt in. Reprehenderit voluptatum reprehenderit impedit quae dolorem temporibus sapiente.	negotiation	renewal	25025.02	2026-04-18 15:50:14	20	2026-04-01 13:51:32	2026-04-01 13:51:32
19	Cold Call	Deleniti assumenda voluptate est a ullam qui. Neque dolores ad vel sit voluptatum. Omnis et corrupti sit consequatur quidem consequuntur.	qualification	new_business	38233.63	2026-06-16 12:28:48	1	2026-04-01 13:51:32	2026-04-01 13:51:32
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
vx6nf0WCy9QYTfteA0bN2YilUMqdFMHzYy3PPaG1	7	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:149.0) Gecko/20100101 Firefox/149.0	YTo1OntzOjY6Il90b2tlbiI7czo0MDoiQlYzeFhSSDJ2b1Y1aWgxTGZFT2FHMEV2WHJMS0gxd0VRWDE2NEJkWCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjQxOiJodHRwczovL2Jpc2N1aXQudGVzdDo4NDQzL2NsaWVudHM/c2VhcmNoPSI7czo1OiJyb3V0ZSI7czoxMzoiY2xpZW50cy5pbmRleCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjc7fQ==	1775069423
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_user, name, email, email_verified_at, password, last_login, remember_token, role_id, created_at, updated_at, two_factor_secret, two_factor_recovery_codes, two_factor_confirmed_at) FROM stdin;
1	Admin Biscuit	admin@biscuit.fr	\N	$2y$12$La84UiY0vHW1m16zeq8R6OxgZsqSj0Q4U.oFoz6nKU64xaxKOc4aS	\N	\N	1	2026-04-01 13:51:27	2026-04-01 13:51:27	\N	\N	\N
2	Lawrence Parisian	oauer@example.org	\N	$2y$12$Loiy5zA5JAAIFYWSumTFfO3OE6uSMLaVt2dpXSBgYeB5WJUSC2nWy	\N	\N	3	2026-04-01 13:51:30	2026-04-01 13:51:30	\N	\N	\N
3	Viola Streich	paige86@example.org	\N	$2y$12$PhCH1HsWl5exBwz3TFAFFuU4WRK/z6eZNAGxH6kCebsfoa.kCZwmu	\N	\N	3	2026-04-01 13:51:30	2026-04-01 13:51:30	\N	\N	\N
4	Dr. Camron Rutherford IV	loyce.hegmann@example.org	\N	$2y$12$iBwurqb0cZMIOcbXoMywguAj39.a3Rihp6VTKHR7qSoBMgYSzwUBO	\N	\N	3	2026-04-01 13:51:30	2026-04-01 13:51:30	\N	\N	\N
5	Jaycee Stoltenberg	nbauch@example.com	\N	$2y$12$PuJFrgxPvoJF3uVIVkiCiuXWlwJ5dIJCJH/0oRdSFP9jw2DtSEnVu	\N	\N	3	2026-04-01 13:51:31	2026-04-01 13:51:31	\N	\N	\N
6	Raegan Koch	ukrajcik@example.net	\N	$2y$12$5m3cuqs8cV/d5FXNzP4ZzOaOKnMjomH8Qk6zmzk4HmnmAe9NUWz6.	\N	\N	3	2026-04-01 13:51:31	2026-04-01 13:51:31	\N	\N	\N
7	test	test@test.com	\N	$2y$12$saMV7edHl/AePQxFCzKiv.bvLaWCxsYByT6.M7qSVsM6IWXyE3UPW	\N	vkzPnHXLeWShPC8qEAvqVr7PRxii2dMz19TWL12FkJ4hbCJvj6XE9zgim8d3	3	2026-04-01 13:54:42	2026-04-01 13:54:42	\N	\N	\N
\.


--
-- Name: activities_id_activity_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activities_id_activity_seq', 5, true);


--
-- Name: activity_client_id_activity_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activity_client_id_activity_client_seq', 10, true);


--
-- Name: addresses_id_address_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.addresses_id_address_seq', 20, true);


--
-- Name: cities_id_city_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_city_seq', 69, true);


--
-- Name: client_user_id_client_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_user_id_client_user_seq', 29, true);


--
-- Name: clients_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_client_seq', 20, true);


--
-- Name: contacts_id_contact_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_contact_seq', 38, true);


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

SELECT pg_catalog.setval('public.opportunities_id_opportunity_seq', 40, true);


--
-- Name: roles_id_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_role_seq', 3, true);


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

\unrestrict uJoXMuuUoQbZEtC8EN4pnnM1OEIY43NCBlOGddnYSUWQwXBjKppOHa0JKELF3Ts

