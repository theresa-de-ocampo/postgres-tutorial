SELECT
  '100'::INTEGER,
  '23-OCT-2018'::DATE;
  
SELECT CAST('100' AS INTEGER);

-- : ERROR: invalid input syntax for type integer: "100C"
SELECT CAST('100C' AS INTEGER);

-- ERROR: type "double" does not exist
-- ERROR: type "number" does not exist
SELECT CAST('10.2' AS DOUBLE);

SELECT CAST('10.2' AS DOUBLE PRECISION);

SELECT CAST('10.2' AS NUMERIC);

CREATE TABLE rating(
  id SERIAL PRIMARY KEY,
  rate CHAR(1) NOT NULL
);

INSERT INTO rating (rate)
VALUES ('A'), ('B'), ('C');

INSERT INTO rating (rate)
VALUES (1), (2), (3);

SELECT * FROM rating;

-- E before the string indicates that it is an escape string.
-- Backslashes are treated as escape characters.
-- \\ was used to escape the backslash in order to represent an acutal backslash.
SELECT
  id,
  CASE
    WHEN rate ~ E'^\\d+$' THEN CAST(rate AS integer)
    ELSE 0
  END AS rate
FROM
  rating;
  