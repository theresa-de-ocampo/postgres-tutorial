/**
 * The ALL operator compares a value to a set of values returned by a subquery.
 * [SYNTAX]:
 *    comparison operator ALL (subquery)
 * 
 * [HOW IT WORKS]:
 * (1) column_name > ALL (subquery)
 *    evaluates to true if a value is greater than the biggest value returned by the subqery
 * (2) columnd_name >= ALL (subquery)
 *    evaluates to true if a value is greater than or equal to the biggest value returned by the subquery.
 * (3) column_name < ALL (subquery)
 *    evaluates to true if a value is less than the smallest value returned by the subquery.
 * (4) column_name <= ALL (subquery)
 *    evaluates to true if a value is less than or equal to the smallest value returned by the subquery.
 * (5) column_name = ALL (subquery)
 *    evaluates to true if value is equal to every value returned by the subquery.
 * (6) column_name != ALL (subquery)
 *    evaluates to true if a value is not equal to every value returned by the subquery.
 * 
 * In case the subquery returns no rows, then the ALL operator always evaluates to true.
 */

-- Find film whose lenth is greater than all of the average lengths per rating.
SELECT
  film_id,
  title,
  length
FROM
  film
WHERE
  length > ALL (
    SELECT
      ROUND(AVG(length), 2)
    FROM
      film
    GROUP BY  
      rating
  )
ORDER BY
  length DESC;


-- Demonstration of Item #1
SELECT
  film_id,
  title,
  length
FROM
  film
WHERE
  length >= ALL (
    SELECT
      length
    FROM
      film
  )
ORDER BY
  length DESC;

-- Demonstration of Item #5
SELECT
  film_id,
  title,
  length
FROM
  film
WHERE
  length = ALL (
    SELECT
      length
    FROM
      film
  )
ORDER BY
  length DESC;

