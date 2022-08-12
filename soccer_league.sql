-- from the terminal run:
-- psql < soccer_league.sql
DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE refs (id SERIAL PRIMARY KEY, ref_name TEXT NOT NULL);

CREATE TABLE season (id SERIAL PRIMARY KEY, yr INT NOT NULL);

CREATE TABLE teams (
  id SERIAL PRIMARY KEY,
  teamname TEXT NOT NULL
);

CREATE TABLE players (
  id SERIAL PRIMARY KEY,
  player text NOT NULL,
  teamid INT NOT NULL REFERENCES teams
);

CREATE TABLE matches (
  id SERIAL PRIMARY KEY,
  match_date DATE NOT NULL,
  seasonid INT NOT NULL REFERENCES season,
  refid INT NOT NULL REFERENCES refs,
  team1 INT NOT NULL REFERENCES teams,
  team2 INT NOT NULL REFERENCES teams,
  winner INT REFERENCES teams
);

CREATE TABLE goals (
  id serial NOT NULL,
  playerid INT NOT NULL REFERENCES players,
  matchid INT NOT NULL REFERENCES matches
);





