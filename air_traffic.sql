-- from the terminal run:
-- psql < air_traffic.sql
DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic 

CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  country TEXT NOT NULL UNIQUE
);

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  city TEXT NOT NULL UNIQUE,
  country INT NOT NULL REFERENCES countries
);

CREATE TABLE airlines (
  id SERIAL PRIMARY KEY,
  airline TEXT NOT NULL UNIQUE
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airlineid INT NOT NULL REFERENCES airlines,
  originid INT NOT NULL REFERENCES cities,
  destinationid INT NOT NULL REFERENCES cities
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customerid INT REFERENCES customers,
  flightid INT REFERENCES flights,
  seat TEXT NOT NULL
);

INSERT INTO countries (country)
VALUES ('United States'),
  ('Japan'),
  ('United Kingdom'),
  ('Mexico'),
  ('France'),
  ('Morocco'),
  ('UAE'),
  ('China'),
  ('Brazil'),
  ('Chile');

INSERT INTO cities (city, country)
VALUES ('Washington DC', 1),
  ('Seattle', 1),
  ('Tokyo', 2),
  ('London', 3),
  ('Los Angeles', 1),
  ('Las Vegas', 1),
  ('Mexico City', 4),
  ('Paris', 5),
  ('Casablanca', 6),
  ('Dubai', 7),
  ('Beijing', 8),
  ('New York', 1),
  ('Charlotte', 1),
  ('Cedar Rapids', 1),
  ('Chicago', 1),
  ('New Orleans', 1),
  ('Sao Paolo', 9),
  ('Santiago', 10);

INSERT INTO airlines (airline)
VALUES ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil');

INSERT INTO customers (first_name, last_name)
VALUES ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Waneta', 'Skeleton'),
  ('Berkie', 'Wycliff'),
  ('Alvin', 'Leathes'),
  ('Berkie', 'Wycliff'),
  ('Cory', 'Squibbes');

INSERT INTO flights (
    departure,
    arrival,
    airlineid,
    originid,
    destinationid
  )
VALUES (
    '2018-04-08 09:00:00',
    '2018-04-08 12:00:00',
    1,
    1,
    2
  ),
  (
    '2018-12-19 12:45:00',
    '2018-12-19 16:15:00',
    2,
    3,
    4
  ),
  (
    '2018-01-02 07:00:00',
    '2018-01-02 08:03:00',
    3,
    5,
    6
  ),
  (
    '2018-04-15 16:50:00',
    '2018-04-15 21:00:00',
    3,
    2,
    7
  ),
  (
    '2018-08-01 18:30:00',
    '2018-08-01 21:50:00',
    4,
    8,
    9
  ),
  (
    '2018-10-31 01:15:00',
    '2018-10-31 12:55:00',
    5,
    10,
    11
  ),
  (
    '2019-02-06 06:00:00',
    '2019-02-06 07:47:00',
    1,
    12,
    13
  ),
  (
    '2018-12-22 14:42:00',
    '2018-12-22 15:56:00',
    6,
    14,
    15
  ),
  (
    '2019-02-06 16:28:00',
    '2019-02-06 19:18:00',
    6,
    13,
    16
  ),
  (
    '2019-01-20 19:30:00',
    '2019-01-20 22:45:00',
    7,
    17,
    18
  );

INSERT INTO tickets (flightid, customerid, seat)
VALUES (1, 1, '33B'),
  (2, 2, '8A'),
  (3, 3, '12F'),
  (4, 1, '20A'),
  (5, 4, '23D'),
  (6, 2, '18C'),
  (7, 5, '9E'),
  (8, 6, '1A'),
  (9, 7, '32B'),
  (10, 8, '10D'),
  (7, 1, '11C'),
  (7, 3, '12D');

SAMPLE QUERYS
SELECT departure,
  arrival,
  airline,
  oCity.city,
  oCont.country,
  dCity.city,
  dCont.country
FROM flights
  JOIN airlines ON airlineid = airlines.id
  JOIN cities oCity ON flights.originid = oCity.id
  JOIN cities dCity ON flights.destinationid = dCity.id
  JOIN countries oCont ON oCity.country = oCont.id
  JOIN countries dCont ON dCity.country = dCont.id
ORDER BY departure;

SELECT tickets.id,
  first_name,
  last_name,
  seat,
  flightid,
  departure,
  arrival,
  airline,
  oCity.city AS origin_city,
  oCont.country AS origin_country,
  dCity.city AS destination_city,
  dCont.country AS destination_country
FROM tickets
  JOIN customers ON customerid = customers.id
  JOIN flights ON flightid = flights.id
  JOIN airlines ON airlineid = airlines.id
  JOIN cities oCity ON flights.originid = oCity.id
  JOIN cities dCity ON flights.destinationid = dCity.id
  JOIN countries oCont ON oCity.country = oCont.id
  JOIN countries dCont ON dCity.country = dCont.id
WHERE EXTRACT(
    YEAR
    FROM departure
  ) = 2019
ORDER BY tickets.id;