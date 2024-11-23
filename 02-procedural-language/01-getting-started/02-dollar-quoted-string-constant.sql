/**
 * Dollar-quoted string constants allow you to construct strings that contain single quotes
 * without a need to escape them.
 */
SELECT 'Hi!';
SELECT 'Hi, I''m Teriz.';
SELECT $$Hi, I'm Teriz$$;

-- Tags are optional
SELECT $intro$Hi, I'm Teriz$intro$;

/**
 * Example 1: Using Dollar-Quoted String Constants in an Anonymous Block
 * An anonymous block is a block of code that is not named and is not stored in the database.
 * Anonymous blocks are used for one-time execution such as testing, and are executed inside a
 * DO statement.
 */

DO '
  DECLARE
    film_count INT;

  BEGIN
    SELECT
      COUNT(*)
    INTO
      film_count
    FROM
      film;

    RAISE NOTICE ''The number of films: %'', film_count;
  END;
';

DO $$
  DECLARE
    film_count INT;

  BEGIN
    SELECT
      COUNT(*)
    INTO
      film_count
    FROM
      film;

    RAISE NOTICE 'The number of films: %', film_count;
  END;
$$;

/**
 * Example 2: Using Dollar-Quoted String Constants in Functions
 * If the function has many statements, it becomes more difficult to read.
 */
CREATE FUNCTION function_name(param_list)
RETURNS data_type
LANGUAGE language_name
AS
  'function_body';

CREATE FUNCTION find_film_by_id(id INT)
RETURNS film
LANGUAGE SQL
AS '
  SELECT 
    *
  FROM
    film
  WHERE
    film_id = id;
';

CREATE OR REPLACE FUNCTION find_film_by_id(id INT)
RETURNS film
LANGUAGE SQL
AS $$
  SELECT 
    *
  FROM
    film
  WHERE
    film_id = id;
$$;


SELECT * FROM find_film_by_id(133);

/**
 * Do use quoted-dollar string constants in anonymous blocks, user-defined functions, and
 * stored procedures.
 */
