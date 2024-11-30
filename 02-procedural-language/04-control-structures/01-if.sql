/**
 * The FOUND is a global variable that is available in PL/pgSQL.
 * The SELECT INTO statement sets the found variable if a row is assigned,
 * or false if no row is returned.
 */

DO $$
  DECLARE
    v_selected_film film%ROWTYPE;
    v_film_id film.film_id%TYPE = 0;

  BEGIN
    SELECT
      *
    INTO
      v_selected_film
    FROM
      film
    WHERE
      film_id = v_film_id;

    IF NOT FOUND THEN
      RAISE NOTICE 'Film % does not exists', v_film_id;
    END IF;
  END;
$$;

DO $$
  DECLARE
    v_selected_film film%ROWTYPE;
    v_film_id film.film_id%TYPE = 100;

  BEGIN
    SELECT
      *
    INTO
      v_selected_film
    FROM
      film
    WHERE
      film_id = v_film_id;

    IF FOUND THEN
      RAISE NOTICE 'Film Title: %', v_selected_film.title;
    ELSE
      RAISE NOTICE 'Film % does not exists', v_film_id;
    END IF;
  END;
$$;

DO $$
  DECLARE
    v_selected_film film%ROWTYPE;
    v_film_id film.film_id%TYPE = 100;
    v_length_description VARCHAR(30);

  BEGIN
    SELECT
      *
    INTO
      v_selected_film
    FROM
      film
    WHERE
      film_id = v_film_id;

    IF FOUND THEN
      IF v_selected_film.length < 50 THEN
        v_length_description = 'short';
      ELSEIF v_selected_film.length < 120 THEN
        v_length_description = 'medium';
      ELSE
        v_length_description = 'long';
      END IF;
      
      RAISE NOTICE 'The % film is %.', v_selected_film.title, v_length_description;
    ELSE
      RAISE NOTICE 'Film % does not exists', v_film_id;
    END IF;
  END;
$$;