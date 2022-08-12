-- from the terminal run:
-- psql < craigslist.sql
DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;

\c craigslist 
CREATE TABLE regions (
  id SERIAL PRIMARY KEY,
  region TEXT NOT NULL
);

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(15) NOT NULL UNIQUE,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  preferred_region INTEGER REFERENCES regions
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  category TEXT NOT NULL
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  userid INTEGER NOT NULL REFERENCES users,
  regionid INTEGER NOT NULL REFERENCES regions,
  categoryid INTEGER NOT NULL REFERENCES categories,
  title VARCHAR(30) NOT NULL,
  text TEXT,
  location TEXT
);

INSERT INTO regions(region)
VALUES ('north'),
  ('south'),
  ('east'),
  ('west');

INSERT INTO categories(category)
VALUES ('selling'),
  ('buying'),
  ('chatting');

-- ?? For posts.userid etc, could you REFERENCES user(username) instead?.
-- ?? Dont understand purpose of using 'REFERENCES' vs just assigning the value without 'REFERENCES'
INSERT INTO users(username, email, password, preferred_region)
VALUES ('beans', 'yahoo.com', 'password123', 1),
  ('chris', 'gmail.com', 'kljahwdkljha', 2),
  ('coffeeman', 'facebook.com', '919191', 4);

INSERT INTO post (
    userid,
    regionid,
    categoryid,
    title,
    text,
    location
  )
VALUES (
    1,
    2,
    3,
    'just chattin here',
    'yo wussup yall',
    'palm beach'
  ),
  (
    3,
    1,
    2,
    'selling iphone',
    'used',
    'new york'
  );