/*
 * PL/pgSQL Row Types
 *    - Used to declare row variables that hold a complete row of a result set.
 *    - Variables of composite types.
 * */
DO $$
  DECLARE selected_actor actor%ROWTYPE;
  
  BEGIN
    SELECT *
    FROM actor
    INTO selected_actor
    WHERE actor_id = 10;
  
    RAISE NOTICE
      'The name of the actor is % %', selected_actor.first_name, selected_actor.last_name;
  END;
  
$$;