-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.employee_verifications
(
    id integer NOT NULL,
    employee_id integer NOT NULL,
    email_verification_status boolean NOT NULL,
    email_verification_date date,
    PRIMARY KEY (id)
);

CREATE TABLE public.employees
(
    user_id integer NOT NULL,
    name character varying NOT NULL,
    lastname character varying NOT NULL,
    birthdate date NOT NULL,
    identity_number smallint NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.employer_verifications
(
    id integer NOT NULL,
    employer_id integer NOT NULL,
    system_verification_status boolean NOT NULL,
    system_verification_date date,
    email_verification_status boolean NOT NULL,
    email_verification_date date,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers
(
    user_id integer NOT NULL,
    company_name character varying NOT NULL,
    website character varying NOT NULL,
    phone character varying NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.job_positions
(
    id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 0 MINVALUE 0 MAXVALUE 1000 CACHE 1 ),
    position_description character varying NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.system_users
(
    user_id integer NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.users
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 0 MINVALUE 0 MAXVALUE 2147483647 CACHE 1 ),
    email character varying NOT NULL,
    password character varying NOT NULL,
    create_date date NOT NULL,
    last_update_date date NOT NULL,
    is_deleted boolean NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public.employees
    ADD FOREIGN KEY (user_id)
    REFERENCES public.employee_verifications (employee_id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.employer_verifications (employer_id)
    NOT VALID;


ALTER TABLE public.users
    ADD FOREIGN KEY (id)
    REFERENCES public.system_users (user_id)
    NOT VALID;


ALTER TABLE public.users
    ADD FOREIGN KEY (id)
    REFERENCES public.employees (user_id)
    NOT VALID;


ALTER TABLE public.users
    ADD FOREIGN KEY (id)
    REFERENCES public.employers (user_id)
    NOT VALID;

END;