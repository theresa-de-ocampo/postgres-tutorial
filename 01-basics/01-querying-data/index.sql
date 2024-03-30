SELECT
  first_name || ' ' || last_name AS full_name,
  email
FROM
  customer;

CREATE TABLE sort_demo (
  num INT
);

INSERT INTO sort_demo (num)
VALUES (1), (2), (3), (NULL);

/* 
  Use the NULLS FIRST and NULLS LAST options to explicitly specify the order of NULL with other non-null values.
 */
SELECT num
FROM sort_demo
ORDER BY num NULLS FIRST;

CREATE TABLE distinct_demo (
  id SERIAL NOT NULL PRIMARY KEY,
  bcolor VARCHAR,
  fcolor VARCHAR
);

INSERT INTO distinct_demo (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  ('red', 'green'),
  ('red', 'blue'),
  ('green', 'red'),
  ('green', 'blue'),
  ('green', 'green'),
  ('blue', 'red'),
  ('blue', 'green'),
  ('blue', 'blue');

SELECT DISTINCT bcolor
FROM distinct_demo
ORDER BY bcolor;

/* 
  If you specify multiple columns, the DISTINCT clause will evaluate the duplicate based on the combination of the values of these columns.

  The query returns the unique combination of bcolor, and fcolor from the distinct_demo table. Notice that the distinct_demo table has two rows with red value in both bcolor, and fcolor columns. When we applied the DISTINCT to both columns, one row was removed from the result set because it is the duplicate.
 */
SELECT DISTINCT bcolor, fcolor
FROM distinct_demo
ORDER BY bcolor, fcolor;

/* 
  PostgreSQL also provides the DISTINCT ON (expression) to keep the "first" row of each group of duplicates.
 */
SELECT
  DISTINCT ON (bcolor) bcolor,
  fcolor
FROM
  distinct_demo
ORDER BY
  bcolor,
  fcolor;