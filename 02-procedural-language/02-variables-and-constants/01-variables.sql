/*
 * Variables are scoped to the block in which they're declared, which means, variables are only
 * accessible within the block and ny nested block.
 * */

-- Assigning values to variables
DO $$
  DECLARE first_name VARCHAR(50);

  BEGIN
    first_name = split_part('Teriz De Ocampo', ' ', 1);
  
    RAISE NOTICE 'The first name is %.', first_name;
  END;
$$;

-- Variable initialization timing
-- PostgreSQL evaluates the initial value of variable, and assigns it when the block is entered.
DO $$
  DECLARE created_at TIME = clock_timestamp();
$$;



