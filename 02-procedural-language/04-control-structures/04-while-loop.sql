/**
 * [<< label >>]
 * WHILE condition LOOP
 *    statements;
 * END LOOP;
 * 
 * In this syntax, PostgreSQL evaluates the condition before executing the statements.
 * It is often referred to as pretest loop.
 */
DO $$
  DECLARE counter INT = 1;

  BEGIN
    WHILE counter <= 5 LOOP
      RAISE NOTICE '%', counter;
      counter = counter + 1;
    END LOOP;
  END;
$$;