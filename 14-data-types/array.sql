/*
 * Every data type has its own companion array type e.g.,
 * integer has an integer[] array type, character has character[], etc.
 * 
 * In case you define your own data type
 * Postgres creates a corresponding array type in the background for you.
 * */

CREATE TABLE contact (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  phones TEXT[]
);

-- ARRAY Constructor
INSERT INTO contact(first_name, last_name, phones)
VALUES ('Teriz', 'De Ocampo', ARRAY['09073981734', '(046)-412-4806']);

-- Curly Braces
INSERT INTO
  contact(first_name, last_name, phones)
VALUES
  ('Grant', 'MacLaren', '{"(408)-589-5841"}'),
  ('Marcy', 'Warton', '{"(046)-391-0877", "(048)-591-3824"}');

SELECT * FROM contact;

/*
 * We can access array elements using index. 
 * Postgres uses one-based numbering for array elements
 * */
SELECT
  concat(first_name, ' ', last_name) AS name,
  phones[1]
FROM
  contact;
  
/*
 * We can use array element in WHERE clause as the condition to filter the rows.
 * For e.g., to find out who has the secondary phone number of (048)-591-3824:
 * */
SELECT
  concat(first_name, ' ', last_name) AS name
FROM
  contact
WHERE
  phones[2] = '(048)-591-3824' ;
  
-- *** Modifying PostgreSQL Array
-- Postgres allows you to update each element of an array or the whole array.
UPDATE contact
SET phones[2] = '09071923384'
WHERE id = 1;

UPDATE contact
SET phones = ARRAY['09058517730']
WHERE id = 1;

SELECT * FROM contact;

/*
 * Suppose we want to know who has the phone number (048)-591-3824
 * regardless of position of the phone number in phones array, we use ANY() function
 * */
SELECT *
FROM contact
WHERE '(048)-591-3824' = ANY(phones);

-- Postgres provides the unnest() function to expand an array to a list of rows.
SELECT
  first_name,
  last_name,
  unnest(phones)
FROM
  contact;