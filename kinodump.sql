--
-- PostgreSQL database dump
--

\restrict BdV3x4af5TmOhkfe2xc4kW8NxcjvI77iVbYYoQOjM4n30RWYRXcOHsDRm8Mpz3B

-- Dumped from database version 16.13
-- Dumped by pg_dump version 18.6

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

--
-- Name: kino; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA kino;


ALTER SCHEMA kino OWNER TO postgres;

--
-- Name: booking_status; Type: TYPE; Schema: kino; Owner: postgres
--

CREATE TYPE kino.booking_status AS ENUM (
    'pending',
    'accepted',
    'declined'
);


ALTER TYPE kino.booking_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking_seats; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.booking_seats (
    booking_id bigint NOT NULL,
    seat_id bigint NOT NULL,
    price real NOT NULL
);


ALTER TABLE kino.booking_seats OWNER TO postgres;

--
-- Name: bookings; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.bookings (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    screening_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status kino.booking_status DEFAULT 'pending'::kino.booking_status NOT NULL
);


ALTER TABLE kino.bookings OWNER TO postgres;

--
-- Name: cinemas; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.cinemas (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255) NOT NULL
);


ALTER TABLE kino.cinemas OWNER TO postgres;

--
-- Name: halls; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.halls (
    id bigint NOT NULL,
    cinema_id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE kino.halls OWNER TO postgres;

--
-- Name: movies; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.movies (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    rating real NOT NULL,
    duration integer NOT NULL,
    genre character varying(255) NOT NULL,
    age_rating character varying(255) NOT NULL,
    poster text NOT NULL,
    trailer text NOT NULL,
    realease_date date NOT NULL
);


ALTER TABLE kino.movies OWNER TO postgres;

--
-- Name: receipts; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.receipts (
    id bigint NOT NULL,
    booking_id bigint NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_method character varying(50) NOT NULL,
    payment_status character varying(50) NOT NULL,
    transaction_id character varying(255),
    issued_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE kino.receipts OWNER TO postgres;

--
-- Name: screenings; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.screenings (
    id bigint NOT NULL,
    movie_id bigint NOT NULL,
    hall_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone NOT NULL
);


ALTER TABLE kino.screenings OWNER TO postgres;

--
-- Name: seats; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.seats (
    id bigint NOT NULL,
    hall_id bigint NOT NULL,
    "row" character varying(20) NOT NULL,
    seat_number integer NOT NULL,
    seat_type character varying(255) NOT NULL
);


ALTER TABLE kino.seats OWNER TO postgres;

--
-- Name: tickets; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino.tickets (
    id bigint NOT NULL,
    booking_id bigint NOT NULL,
    seat_id bigint NOT NULL,
    ticket_code character varying(100) NOT NULL,
    status character varying(50) DEFAULT 'ACTIVE'::character varying NOT NULL,
    is_used boolean DEFAULT false NOT NULL,
    issued_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE kino.tickets OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: kino; Owner: postgres
--

CREATE TABLE kino."user" (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(2048) NOT NULL,
    role character varying(50) DEFAULT USER NOT NULL
);


ALTER TABLE kino."user" OWNER TO postgres;

--
-- Data for Name: booking_seats; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.booking_seats (booking_id, seat_id, price) FROM stdin;
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.bookings (id, user_id, screening_id, created_at, status) FROM stdin;
\.


--
-- Data for Name: cinemas; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.cinemas (id, name, address) FROM stdin;
\.


--
-- Data for Name: halls; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.halls (id, cinema_id, name) FROM stdin;
\.


--
-- Data for Name: movies; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.movies (id, title, description, rating, duration, genre, age_rating, poster, trailer, realease_date) FROM stdin;
\.


--
-- Data for Name: receipts; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.receipts (id, booking_id, amount, payment_method, payment_status, transaction_id, issued_at) FROM stdin;
\.


--
-- Data for Name: screenings; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.screenings (id, movie_id, hall_id, start_time, end_time) FROM stdin;
\.


--
-- Data for Name: seats; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.seats (id, hall_id, "row", seat_number, seat_type) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino.tickets (id, booking_id, seat_id, ticket_code, status, is_used, issued_at) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: kino; Owner: postgres
--

COPY kino."user" (id, first_name, last_name, email, password, role) FROM stdin;
\.


--
-- Name: bookings bookings_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.bookings
    ADD CONSTRAINT bookings_pk PRIMARY KEY (id);


--
-- Name: cinemas cinemas_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.cinemas
    ADD CONSTRAINT cinemas_pk PRIMARY KEY (id);


--
-- Name: halls halls_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.halls
    ADD CONSTRAINT halls_pk PRIMARY KEY (id);


--
-- Name: movies movies_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.movies
    ADD CONSTRAINT movies_pk PRIMARY KEY (id);


--
-- Name: receipts receipts_booking_id_unique; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.receipts
    ADD CONSTRAINT receipts_booking_id_unique UNIQUE (booking_id);


--
-- Name: receipts receipts_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.receipts
    ADD CONSTRAINT receipts_pk PRIMARY KEY (id);


--
-- Name: screenings screenings_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.screenings
    ADD CONSTRAINT screenings_pk PRIMARY KEY (id);


--
-- Name: seats seats_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.seats
    ADD CONSTRAINT seats_pk PRIMARY KEY (id);


--
-- Name: tickets tickets_booking_seat_unique; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.tickets
    ADD CONSTRAINT tickets_booking_seat_unique UNIQUE (booking_id, seat_id);


--
-- Name: tickets tickets_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.tickets
    ADD CONSTRAINT tickets_pk PRIMARY KEY (id);


--
-- Name: tickets tickets_ticket_code_unique; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.tickets
    ADD CONSTRAINT tickets_ticket_code_unique UNIQUE (ticket_code);


--
-- Name: user user_pk; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino."user"
    ADD CONSTRAINT user_pk PRIMARY KEY (id);


--
-- Name: user user_pk_2; Type: CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino."user"
    ADD CONSTRAINT user_pk_2 UNIQUE (email);


--
-- Name: booking_seats booking_seats_bookings_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.booking_seats
    ADD CONSTRAINT booking_seats_bookings_id_fk FOREIGN KEY (booking_id) REFERENCES kino.bookings(id);


--
-- Name: booking_seats booking_seats_seats_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.booking_seats
    ADD CONSTRAINT booking_seats_seats_id_fk FOREIGN KEY (seat_id) REFERENCES kino.seats(id);


--
-- Name: bookings bookings_screenings_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.bookings
    ADD CONSTRAINT bookings_screenings_id_fk FOREIGN KEY (screening_id) REFERENCES kino.screenings(id);


--
-- Name: bookings bookings_user_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.bookings
    ADD CONSTRAINT bookings_user_id_fk FOREIGN KEY (user_id) REFERENCES kino."user"(id);


--
-- Name: halls halls_cinemas_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.halls
    ADD CONSTRAINT halls_cinemas_id_fk FOREIGN KEY (cinema_id) REFERENCES kino.cinemas(id) ON DELETE CASCADE;


--
-- Name: receipts receipts_bookings_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.receipts
    ADD CONSTRAINT receipts_bookings_id_fk FOREIGN KEY (booking_id) REFERENCES kino.bookings(id) ON DELETE CASCADE;


--
-- Name: screenings screenings_halls_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.screenings
    ADD CONSTRAINT screenings_halls_id_fk FOREIGN KEY (hall_id) REFERENCES kino.halls(id);


--
-- Name: screenings screenings_movies_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.screenings
    ADD CONSTRAINT screenings_movies_id_fk FOREIGN KEY (movie_id) REFERENCES kino.movies(id);


--
-- Name: seats seats_halls_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.seats
    ADD CONSTRAINT seats_halls_id_fk FOREIGN KEY (hall_id) REFERENCES kino.halls(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_bookings_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.tickets
    ADD CONSTRAINT tickets_bookings_id_fk FOREIGN KEY (booking_id) REFERENCES kino.bookings(id) ON DELETE CASCADE;


--
-- Name: tickets tickets_seats_id_fk; Type: FK CONSTRAINT; Schema: kino; Owner: postgres
--

ALTER TABLE ONLY kino.tickets
    ADD CONSTRAINT tickets_seats_id_fk FOREIGN KEY (seat_id) REFERENCES kino.seats(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict BdV3x4af5TmOhkfe2xc4kW8NxcjvI77iVbYYoQOjM4n30RWYRXcOHsDRm8Mpz3B

