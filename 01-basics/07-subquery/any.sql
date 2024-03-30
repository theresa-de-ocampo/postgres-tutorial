SELECT MAX(rental_duration) FROM film;
SELECT * FROM film;

/**
 * The ANY operator compares a value to a set of values returned by a subquery.
 * [SYNTAX]:
 *    expression operator ANY (subquery)
 * 
 * [RULES]:
 * (1) The subquery must return exactly one column.
 * (2) The any operator must be preceded by one of the following comparison operator:
 *     =, <=, >, <, >=, <>
 * (3) The any operator returns true if any value of the subquery meets the condition.
 *     Otherwise, it returns false.
 * 
 * Note that SOME is a synonym for ANY, meaning that you can substitute SOME for ANY.
 */

-- Get maximum length of film grouped by film category
SELECT
  MAX(length)
FROM
  film
INNER JOIN
  film_category USING (film_id)
GROUP BY
  category_id;

-- Find films whose lengths are greater than or equal to the maximum length of any film category.
SELECT
  title
FROM
  film
WHERE
  length >= ANY (
    SELECT
      MAX(length)
    FROM
      film
    INNER JOIN
      film_category USING (film_id)
    GROUP BY
      category_id
  );

-- ANY vs IN
/**
 * = ANY is equivalent to IN
 * But <> ANY is different from NOT IN
 * 
 * x <> ANY (a, b, c)
 * 
 * is equivalent to
 * 
 * x <> a OR x <> b OR x <> c
 */ 

-- In case subquery returns no rows, then the ANY operator always evaluates to false.
SELECT
  title
FROM
  film
WHERE
  length >= ANY (
    SELECT
      MAX(length)
    FROM
      film
    WHERE
      film_id = 7777
  );

-- [Use-Case] You defined a function that takes in an array of allowed values
-- You can then use ANY, IN will not work this particular case.

