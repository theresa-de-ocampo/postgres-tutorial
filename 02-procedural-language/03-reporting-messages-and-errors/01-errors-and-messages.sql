/**
 * Use the RAISE statement to issue a message. 
 * 
 * RAISE level format;
 * 
 * The level option determines the error severity with the following values:
 * debug
 * log
 * notice
 * info
 * warning
 * exception
 * 
 * If you don't specify the level, the raise statement will use the exception level that raises an
 * error and stops the current transaction by default.
 */

/**
 * Notice that not all messages are reported back to the client.
 * Postgres only reports the info, warning, and notice level messages back to the client.
 * This is controlled by client_min_messages, and log_min_messages configuration parameters.
 */
DO $$
  BEGIN
    RAISE DEBUG 'Debug Message %', NOW();
    RAISE LOG 'Log Message %', NOW();
    RAISE NOTICE 'Notice Message %', NOW();
    RAISE INFO 'Information Message %', NOW();
    RAISE WARNING 'Warning Message %', NOW();
  END;
$$;

-- ***** RAISING ERRORS
/**
 * Besides raising an error, you can add more information by using the following additional clause:
 * USING option = expression
 * 
 * hint: provide the hint message so that the root cause of the error is easier to discover.
 * detail: give detailed information about the error.
 * errcode: identify the error code, which can be either by condition name or an SQLSTATE code.
 * 
 * https://www.postgresql.org/docs/current/errcodes-appendix.html 
 */

DO $$
  DECLARE
    email VARCHAR(200) = 'theresa@gmail.com';
  
  BEGIN
    RAISE EXCEPTION 'Duplicate Email: %', email
      USING hint = 'Customer has existing records.';
  END;
$$;

/**
 * To signal a generic SQLSTATE value, use 45000 which means "unhandled user-defined exception"
 * 45000 is not a pre-defined SQLSTATE code in PostgreSQL.
 * The appendix lists all the standard and pre-defined SQLSTATE codes that PostgreSQL uses, and
 * 45000 is not included because it is a user-defined code.
 * 
 * The pre-defined SQLSTATE codes listed in the documentaion fall under specific categories like
 * 42XXX for syntax errors or 23XXX for integrity constraint violations.
 * 
 * To avoid conflicts, do not use codes that overlap with pre-defined SQLSTATE codes.
 * Stick to the 45XXX or other classes that are not heavily used in the PostgreSQL pre-defined set.
 */
DO $$
  BEGIN
    RAISE EXCEPTION 'Complainant must only either be a local resident, or an outsider.'
      USING ERRCODE = '45000'; 
  END;
$$;

DO $$
  BEGIN
    RAISE SQLSTATE '77777';
  END;
$$;

DO $$
  BEGIN
    RAISE invalid_regular_expression;
  END;
$$;

DO $$
  BEGIN
    RAISE division_by_zero;
  END;
$$;





