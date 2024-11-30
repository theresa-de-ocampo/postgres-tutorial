/**
 * The loop defines an unconditional loop that executes a block of code repeatedly until terminated
 * by an EXIT or RETURN statement.
 * 
 * <<label>>
 * LOOP
 *    statements;
 * END LOOP;
 * 
 * When you have nested loops, it's necessary to use loop labels.
 * The loop labels allow you to specify the loop in the EXIT and CONTINUE statements,
 * indicating which loop these statements refer to.
 */

DO $$
  DECLARE counter INT = 1;

  BEGIN
    LOOP
      IF counter > 5 THEN
        EXIT;
      END IF;

      RAISE NOTICE '%', counter;
      counter = counter + 1;
    END LOOP;
  END;
$$;


/**
 * In practice, you can combine the IF and EXIT statements into a single statement.
 * 
 *  EXIT WHEN counter = 5;
 */
DO $$
  DECLARE counter INT = 1;

  BEGIN
    LOOP
      EXIT WHEN counter > 5;

      RAISE NOTICE '%', counter;
      counter = counter + 1;
    END LOOP;
  END;
$$;

-- Using a loop with a label
DO $$
  DECLARE counter INT = 1;

  BEGIN
    <<my_loop>>
    LOOP
      EXIT my_loop WHEN counter > 5;

      RAISE NOTICE '%', counter;
      counter = counter + 1;
    END LOOP;
  END;
$$;

-- Nested Loop
DO $$
  DECLARE v_row INT = 1;
  DECLARE v_col INT = 1;

  BEGIN
    <<row_loop>>
    LOOP
      EXIT row_loop WHEN v_row > 3;
      v_col = 1;

      <<col_loop>>
      LOOP
        EXIT col_loop WHEN v_col > 3; 
        RAISE NOTICE '(%, %)', v_row, v_col;
        v_col = v_col + 1;
      END LOOP;

      v_row = v_row + 1;
    END LOOP;
  END;
$$;

