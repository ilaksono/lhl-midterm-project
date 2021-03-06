-- Drop and recreate Users table (Example)

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS maps CASCADE;
DROP TABLE IF EXISTS markers CASCADE;
DROP TABLE IF EXISTS favourites CASCADE;
DROP TABLE IF EXISTS contributors CASCADE;

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  username VARCHAR(250) NOT NULL,
  email VARCHAR (250) NOT NULL,
  password VARCHAR (250) NOT NULL
);

CREATE TABLE maps (
  id SERIAL PRIMARY KEY NOT NULL,
  title VARCHAR(250) NOT NULL,
  description VARCHAR(250),
  owner_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  date_created DATE NOT NULL,
  deleted BOOLEAN NOT NULL DEFAULT false 
);

CREATE TABLE favourites (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  map_id INTEGER REFERENCES maps(id) ON DELETE CASCADE
);

CREATE TABLE contributors (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  map_id INTEGER REFERENCES maps(id) ON DELETE CASCADE
);

CREATE TABLE markers (
  id SERIAL PRIMARY KEY NOT NULL,
  map_id INTEGER REFERENCES maps(id) ON DELETE CASCADE,
  latitude FLOAT8 NOT NULL,
  longitude FLOAT8 NOT NULL,
  title VARCHAR(250) NOT NULL,
  description VARCHAR(250),
  image_url VARCHAR(250) DEFAULT 'https://humanesociety.org/sites/default/files/styles/1441x612/public/2018/08/kitten-440379.jpg?h=c8d00152&itok=HVqvfhtg',
  deleted BOOLEAN NOT NULL DEFAULT false
);
