DO $$
  DECLARE actor_count INT = 0;

  BEGIN
    SELECT COUNT(*)
    INTO actor_count
    FROM actor;
  
    RAISE NOTICE 'The number of actors: %', actor_count;
  END;
  
$$;

/**
 * The INTO clause can appear almost anywhere in the SQL command. 
 * Customarily, it is written either just before or just after the list the select_expressions in
 * a SELECT command, or at the end of the command for other command types
 * It is recommended that you follow this convention in case the PL/pgSQL parser becomes stricter
 * in future versions. 
 */
DO $$
  DECLARE actor_count INT = 0;

  BEGIN
    SELECT COUNT(*)
    FROM actor
    INTO actor_count;
  
    RAISE NOTICE 'The number of actors: %', actor_count;
  END;
  
$$;

-- Using SELECT INTO multiple variables
DO $$
  DECLARE
    v_first_name actor.first_name%TYPE;
    v_last_name actor.last_name%TYPE;
  
  BEGIN
    SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM actor
    WHERE actor_id = 1;
  
    RAISE NOTICE '% %', v_first_name, v_last_name;
  END;
  
$$;