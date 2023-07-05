--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23 (Ubuntu 10.23-0ubuntu0.18.04.2)
-- Dumped by pg_dump version 10.23 (Ubuntu 10.23-0ubuntu0.18.04.2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: stories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stories (
    id bigint NOT NULL,
    uid integer,
    title character varying(1024),
    story_date date,
    story_excerpt character varying(1024),
    story_body text,
    rating double precision,
    rating_count integer,
    story_author_id bigint,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: stories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stories_id_seq OWNED BY public.stories.id;


--
-- Name: story_authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_authors (
    id bigint NOT NULL,
    uid integer,
    oid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: story_authors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.story_authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: story_authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.story_authors_id_seq OWNED BY public.story_authors.id;


--
-- Name: story_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.story_categories (
    id bigint NOT NULL,
    uid integer,
    oid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


--
-- Name: story_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.story_categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: story_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.story_categories_id_seq OWNED BY public.story_categories.id;


--
-- Name: stories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories ALTER COLUMN id SET DEFAULT nextval('public.stories_id_seq'::regclass);


--
-- Name: story_authors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_authors ALTER COLUMN id SET DEFAULT nextval('public.story_authors_id_seq'::regclass);


--
-- Name: story_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_categories ALTER COLUMN id SET DEFAULT nextval('public.story_categories_id_seq'::regclass);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stories stories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_pkey PRIMARY KEY (id);


--
-- Name: story_authors story_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_authors
    ADD CONSTRAINT story_authors_pkey PRIMARY KEY (id);


--
-- Name: story_categories story_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.story_categories
    ADD CONSTRAINT story_categories_pkey PRIMARY KEY (id);


--
-- Name: stories_rating_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stories_rating_index ON public.stories USING btree (rating);


--
-- Name: stories_story_author_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stories_story_author_id_index ON public.stories USING btree (story_author_id);


--
-- Name: stories_story_date_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stories_story_date_index ON public.stories USING btree (story_date);


--
-- Name: stories_title_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stories_title_index ON public.stories USING btree (title);


--
-- Name: stories_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stories_uid_index ON public.stories USING btree (uid);


--
-- Name: story_authors_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX story_authors_name_index ON public.story_authors USING btree (name);


--
-- Name: story_authors_oid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX story_authors_oid_index ON public.story_authors USING btree (oid);


--
-- Name: story_authors_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX story_authors_uid_index ON public.story_authors USING btree (uid);


--
-- Name: story_categories_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX story_categories_name_index ON public.story_categories USING btree (name);


--
-- Name: story_categories_oid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX story_categories_oid_index ON public.story_categories USING btree (oid);


--
-- Name: story_categories_uid_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX story_categories_uid_index ON public.story_categories USING btree (uid);


--
-- Name: stories stories_story_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stories
    ADD CONSTRAINT stories_story_author_id_fkey FOREIGN KEY (story_author_id) REFERENCES public.story_authors(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO public."schema_migrations" (version) VALUES (20230704163543);
INSERT INTO public."schema_migrations" (version) VALUES (20230704195250);
INSERT INTO public."schema_migrations" (version) VALUES (20230705154509);
