/**
 * The continue statement prematurely skips the current iteration of the loop,
 * and starts the next one.
 * 
 * CONTINUE [loop_label] [WHEN condition]
 */

DO $$
  DECLARE counter INT = 0;

  BEGIN
    LOOP
      counter = counter + 1;

      EXIT WHEN counter > 10;
      CONTINUE WHEN MOD(counter, 2) = 0;

      RAISE NOTICE '%', counter;
    END LOOP;
  END;
$$;