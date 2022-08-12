-- from the terminal run:
-- psql < medical_center.sql
DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center 

CREATE TABLE doctors (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  specialty TEXT DEFAULT 'GP',
  phone_number TEXT NOT NULL,
);

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  phone_number TEXT NOT NULL,
  email TEXT NOT NULL,
  address TEXT NOT NULL,
  insurance TEXT
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  doctorid NOT NULL REFERENCES doctors,
  patientid NOT NULL REFERENCES patients,
  date DATE NOT NULL prognosis TEXT
);