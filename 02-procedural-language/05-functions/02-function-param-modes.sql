/**
 * IN Mode
 * A parameter takes in IN mode by default if you do not explicitly specify it.
 */
CREATE OR REPLACE FUNCTION find_film_by_id(p_film_id INT)
  RETURNS VARCHAR
  LANGUAGE plpgsql
AS $$
  DECLARE film_title film.title%TYPE;

  BEGIN
    SELECT
      title
    INTO
      film_title
    FROM
      film
    WHERE
      id = p_film_id;

    IF NOT FOUND THEN
      RAISE 'Film % Not Found', p_film_id;
    END IF;

    RETURN film_title;
  END;
$$;


/**
 * OUT Mode
 * The out parameters are very useful in functions that need to return multiple values.
 */
CREATE OR REPLACE FUNCTION get_film_stat(
  OUT min_len INT,
  OUT max_len INT,
  OUT avg_len NUMERIC
)
LANGUAGE plpgsql
AS $$
  BEGIN
    SELECT
      MIN("length"),
      MAX("length"),
      AVG("length")::NUMERIC(5, 1)
    INTO
      min_len,
      max_len,
      avg_len
    FROM
      film;
  END;
$$;

-- The output of a function is a record
SELECT get_film_stat();

-- To separate the output into columns:
SELECT * FROM get_film_stat();

/**
 * The INOUT Mode
 * It means that the caller can pass an argument to a function.
 * The function changes the argument and returns the updated value.
 */
CREATE OR REPLACE FUNCTION swap(
  INOUT x INT,
  INOUT y INT
)
LANGUAGE plpgsql
AS $$
  BEGIN
    SELECT
      x, y
    INTO
      y, x;
  END;
$$;

SELECT * FROM swap(10, 20);







