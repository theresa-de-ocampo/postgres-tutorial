/**
 * Postgres 9.4 was released in December 2014 adding the FILTER clause to aggregate functions.
 * This clause is quite useful when you want to count or sum specific records when executing GROUP BY.
 */


SELECT
  COUNT(*) AS unfiltered,
  SUM(
    CASE
      WHEN i < 5 THEN 1
      ELSE 0
    END
  ) AS filtered
FROM
  generate_series(1, 10) AS series(i);
  
SELECT
  COUNT(*) AS unfiltered,
  COUNT(*) FILTER(WHERE i < 5) AS fitered
FROM
  generate_series(1, 10) AS series(i);