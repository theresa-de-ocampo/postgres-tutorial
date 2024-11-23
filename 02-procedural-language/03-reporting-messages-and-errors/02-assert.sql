/**
 * The assert statement is a useful shorthand for inserting debugging checks into PL/pgSQL code.
 * assert condition [, message];
 * 
 * condition
 * The condition is a boolean expression that is expected to always return true.
 * If the condition evaluates to true, the assert statement does nothing.
 * In case the condition evaluates to false or null, PostgreSQL raises an assert_failure exception.
 * 
 * If you don't pass the message, PostgreSQL uses the "assertion failed" message by default.
 * Note that you should use the assert statement solely for detecting bugs, not for reporting.
 * To report a message or an error, you use the raise statement instead.
 */

-- assert statement was only introduced at version 9.5
SELECT version();

/**
 * Enable / Disable Assertions
 * PostgreSQL provides the plpgsql.check_asserts configuration parameter to enable or disable
 * assertion testing. If you set this parameter to off, the assert statement will do nothing.
 */
SHOW config_file;



DO $$
  DECLARE film_count INT;
  
  BEGIN
    SELECT
      COUNT(*)
    INTO
      film_count
    FROM
      film;

    assert film_count > 0, 'No Records';
  END;
$$;

DO $$
  DECLARE film_count INT;
  
  BEGIN
    SELECT
      COUNT(*)
    INTO
      film_count
    FROM
      film;

    assert film_count > 1000, 'Less than or equal to 1000 records.';
  END;
$$;