-- from the terminal run:
-- psql < music.sql
DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music 

CREATE TABLE artists (id SERIAL PRIMARY KEY, artist TEXT NOT NULL);

CREATE TABLE producers (id SERIAL PRIMARY KEY, producer TEXT NOT NULL);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  album_name TEXT NOT NULL,
  release_date DATE NOT NULL
);

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  album INT NOT NULL REFERENCES albums
);

CREATE TABLE artists_of_songs (
  id SERIAL PRIMARY KEY,
  songid INT NOT NULL REFERENCES songs,
  artistid INT NOT NULL REFERENCES artists
);

CREATE TABLE producers_of_songs (
  id SERIAL PRIMARY KEY,
  songid INT NOT NULL REFERENCES songs,
  producerid INT NOT NULL REFERENCES producers
);