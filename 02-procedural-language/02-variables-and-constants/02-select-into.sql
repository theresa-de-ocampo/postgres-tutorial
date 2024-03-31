DO $$
  DECLARE actor_count INT = 0;

  BEGIN
    SELECT COUNT(*)
    INTO actor_count
    FROM actor;
  
    RAISE NOTICE 'The number of actors: %', actor_count;
  END;
  
$$;

-- Idk why this is working as well.
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