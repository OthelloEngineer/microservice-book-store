CREATE DATABASE books;

\c books;

CREATE TABLE authors(
    id serial PRIMARY KEY UNIQUE,
    first_name varchar(255),
    last_name varchar(255),
);

CREATE TABLE genres(
    id serial PRIMARY KEY UNIQUE,
    name varchar(255),
);

CREATE TABLE books(
    id serial PRIMARY KEY UNIQUE,
    ISBN varchar(255) UNIQUE,
    name varchar(255),
    author int references authors(id),
    genre int references genres(id),
);