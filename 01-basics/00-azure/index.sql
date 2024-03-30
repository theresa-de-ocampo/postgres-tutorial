CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE client(
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  company VARCHAR(100) UNIQUE NOT NULL,
  start_date DATE DEFAULT CURRENT_DATE NOT NULL
);

INSERT INTO
  client (company, start_date)
VALUES
  ('Jollibee', '2020-11-25'),
  ('Starbucks', CURRENT_DATE);

SELECT * FROM client;

CREATE TABLE lego_themes (
  id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  parent_id INT,
  load_date DATE
);

SELECT * FROM lego_themes;
