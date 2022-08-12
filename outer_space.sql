-- from the terminal run:
-- psql < outer_space.sql
DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space 

CREATE TABLE galaxies (
  id SERIAL PRIMARY KEY,
  galaxy_name TEXT NOT NULL
);

CREATE TABLE planets (
  id SERIAL PRIMARY KEY,
  planet_name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy INT NOT NULL REFERENCES galaxies
);

CREATE TABLE moons (
  id SERIAL PRIMARY KEY,
  moon_name TEXT NOT NULL,
  parent_planet INT REFERENCES planets
);