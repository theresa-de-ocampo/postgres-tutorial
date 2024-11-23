/**
 * Row variables or row-type variables are variables of composite types that can hold a complete row
 * of a result set.
 * 
 * row_variable table_name%ROWTYPE
 * row_variable view_name%ROWTYPE
 */
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