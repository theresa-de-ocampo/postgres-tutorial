/*
 * Since CASE is an expression, you can use it in any places where an expression can be used,
 * e.g., SELECT, WHERE, GROUP BY, HAVING.
 * 
 * If all conditions are false, the CASE expression returns the result that follows the ELSE
 * keyword. If you omit the ELSE clause, the CASE expression returns NULL
 */

SELECT
  title,
  length,
  CASE
    WHEN length < 50 THEN 'Short'
    WHEN length < 120 THEN 'Medium'
    ELSE 'Long'
  END AS duration
FROM
  film
ORDER BY
  title;

-- Using CASE with an aggregate function
-- But better use FILTER instead
SELECT
  SUM(
    CASE WHEN rental_rate = 0.99 THEN 1 ELSE 0 END
  ) AS economy,
  SUM(
    CASE WHEN rental_rate = 1.99 THEN 1 ELSE 0 END
  ) AS mass,
  SUM(
    CASE WHEN rental_rate = 4.99 THEN 1 ELSE 0 END
  ) AS premium
FROM
  film;
  