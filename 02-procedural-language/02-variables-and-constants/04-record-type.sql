/*
 * PostgreSQL provides a type called "record" that is similar to row-type.
 * A record isn't a true type but rather a placeholder. The structure of a record variable will
 * change when you reassign it to another value.
 * 
 * Unlike a row-type variable, a record variable lacks a predefined structure. Instead, the
 * structure of a record variable is determined when an actual row is assigned to it via the
 * `select` or `for` statement.
 * 
 * If you attempt to access a field in a record variable before it's assigned, you'll get an error.
 * */
DO $$
  DECLARE v_record RECORD;

  BEGIN
    SELECT film_id, title, length
    INTO v_record
    FROM film
    WHERE film_id = 200;
  
    RAISE NOTICE '% % %', v_record.film_id, v_record.title, v_record.length;
  END;
  
$$;

-- Using record variables in the for loop statement
DO $$
  DECLARE v_record RECORD;
  
  BEGIN
    FOR v_record IN 
      (
        SELECT title, length
        FROM film
        WHERE length > 50
        ORDER BY length
      )
    LOOP
      RAISE NOTICE '% %', v_record.title, v_record.length;
    END LOOP;
  END;
$$;


