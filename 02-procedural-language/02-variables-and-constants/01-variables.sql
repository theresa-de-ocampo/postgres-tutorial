/*
 * Variables are scoped to the block in which they're declared, which means, variables are only
 * accessible within the block and any nested block.
 * */

-- Declare variables
DO $$
  DECLARE
    counter INT = 1;
    first_name VARCHAR(75) = 'John';
    last_name VARCHAR(75) = 'Doe';
    payment NUMERIC(11, 2) = 20.5;

  BEGIN
    RAISE NOTICE '% % has been paid % USD', first_name, last_name, payment;
  END;
$$;

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
  BEGIN
    RAISE NOTICE '%', created_at;
    PERFORM pg_sleep(3);
    RAISE NOTICE '%', created_at;
  END;
$$;

DO $$
  DECLARE created_at TIME = NOW();
  BEGIN
    RAISE NOTICE '%', created_at;
    PERFORM pg_sleep(3);
    RAISE NOTICE '%', created_at;
  END;
$$;


/*
 * Difference between NOW(), and clock_timestamp()
 * 
 * Say you have 2 two tables with 2 million entries of time from now (indexed).
 * One table created with NOW(), the other with clock_timestamp() using generation_series().
 * You want to select the record where the time column is equal to the current time.
 * 
 * NOW() stays the same, it does not change during the transaction. Thus, PostgreSQL can evaluate
 * the function once and look up the constant in the index.
 * 
 * clock_timestamp() changes all the time. Thus Postgres cannot simply up the value in the index and
 * return the result because clock_timestamp() changes from line to line. This is not only a 
 * performance thing - it is mainly about returning correct results.
 * 
 * https://www.cybertec-postgresql.com/en/postgresql-now-vs-nowtimestamp-vs-clock_timestamp/#:~:text=Keep%20in%20mind%3A%20now(),()%20changes%20all%20the%20time.
 * */
SELECT NOW(), clock_timestamp();


/*
 * Copying Data Types
 * You use the %type to declare a variable that holds a value from the database or another variable.
 * 
 * Advantages
 * (1) You don't need to know the type of column or reference being accessed.
 * (2) If the data type of the referenced column name (or variable) changes,
 *     you don't need to change the block.
 * */
DO $$
  DECLARE
    film_title film.title%TYPE;
    featured_title film_title%TYPE;
  
  BEGIN
    SELECT title
    INTO film_title
    FROM film
    WHERE film_id = 100;
    
    RAISE NOTICE 'Film Title ID 100: %', film_title;
  END;
$$;

/*
 * Variables in blocks and subblocks
 * When you declare a variable in a subblock with the same name as another variable in the outer
 * block, the variable in the outer block is hidden within the subblock.
 * 
 * To access a variable in the outer block, you use the block label to qualify its name.
 * */
DO $$
  <<outer_block>>
    DECLARE counter INTEGER := 0;
    
    BEGIN
      counter = counter + 1;
      RAISE NOTICE 'The current value of counter is %', counter;
    
      DECLARE counter INTEGER := 0;
      
      BEGIN
        counter = counter + 10;
        RAISE NOTICE 'Counter in the subblock is %', counter;
        RAISE NOTICE 'Counter in the outer block is %', outer_block.counter;
      END;
    END
  outer_block;
$$;
