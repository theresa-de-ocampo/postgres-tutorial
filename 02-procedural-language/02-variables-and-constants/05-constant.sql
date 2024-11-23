/**
 * Constants are identifiers whose values cannot be changed during the execution of the code.
 * For instance, during the execution of a block, function, or procedure.
 * 
 * Benefits
 * (1) Conveys meaning
 * (2) Helps reduce maintenance effort.
 *     You only need to modify its value in place where you define the constant.
 */

DO $$
  DECLARE
    c_vat constant NUMERIC = 0.1;
    c_net_price constant NUMERIC = 20.5;

  BEGIN
    RAISE NOTICE 'The selling price is %', c_net_price * (1 + c_vat);
  END;
$$;

/**
 * Similar to the default value of a variable, PostgreSQL evaluates the value for the constant when
 * the block is entered at run-time, not compile-time.
 */
DO $$
  DECLARE
    c_started_at constant TIME = clock_timestamp();

  BEGIN
    PERFORM pg_sleep(3);

    RAISE NOTICE '3s Later';
    RAISE NOTICE 'Current Time %', clock_timestamp();

    PERFORM pg_sleep(3);
    RAISE NOTICE 'Started At %', c_started_at;
  END; 
$$;

DO $$
  DECLARE
    c_started_at constant TIME = NOW();

  BEGIN
    PERFORM pg_sleep(3);

    RAISE NOTICE '3s Later';
    RAISE NOTICE 'Current Time %', NOW();

    PERFORM pg_sleep(3);
    RAISE NOTICE 'Started At %', c_started_at;
  END; 
$$;


