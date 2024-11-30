/**
 * You should not be confused about the CASE statement and CASE expression.
 * The CASE expression evaluates to a value while the CASE statement selects a section to execute
 * based on conditions.
 * 
 * (1) Simple Case Statement
 * CASE search-expression
 *    WHEN expression-1, [, expression-2, ...] THEN
 *      when-statements
 *    ELSE
 *      else-statements
 * END CASE;
 * 
 * The search-expression is an expression that evaluates to a result.
 * The CASE statement compares the result of the search-expression with the expression in each WHEN
 * branch using the equal operator (=) from top to bottom.
 */

DO $$
  DECLARE
    v_rental_rate film.rental_rate%TYPE;
    v_price_segment VARCHAR(30);

  BEGIN
    SELECT
      rental_rate
    INTO
      v_rental_rate
    FROM
      film
    WHERE
      film_id = 100;

    IF FOUND THEN
      CASE v_rental_rate
        WHEN 0.99 THEN
          v_price_segment = 'Mass';
        WHEN 2.99 THEN
          v_price_segment = 'Mainstream';
        WHEN 4.99 THEN
          v_price_segment = 'High End';
        ELSE
          v_price_segment = 'Unspecified';
      END CASE;

      RAISE NOTICE '%', v_price_segment;
    ELSE
      RAISE NOTICE 'Film does not exist.';
    END IF;
  END;
$$;

/**
 * (2) Searched-Case Statement
 * It does not have a search expression.
 * In this syntax, the CASE statement evaluates the boolean expression sequentially from top to bottom.
 */

DO $$
  DECLARE
    v_total_payment NUMERIC;
    v_service_level VARCHAR(25);

  BEGIN
    SELECT
      SUM(amount)
    INTO
      v_total_payment
    FROM
      payment
    WHERE
      customer_id = 100;

    IF FOUND THEN
      CASE
        WHEN v_total_payment > 200 THEN
          v_service_level = 'Platinum';
        WHEN v_total_payment > 100 THEN
          v_service_level = 'Gold';
        ELSE
          v_service_level = 'Silver';
      END CASE;

      RAISE NOTICE 'Service Level: %', v_service_level;
    ELSE
      RAISE NOTICE 'Customer does not exist.';
    END IF;
  END;
$$;

/**
 * If there are no matches and the ELSE section does not exist, the CASE statement will raise a
 * case_not_found exception.
 */
