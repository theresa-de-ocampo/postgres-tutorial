SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name = 'Jamie';

/* Returns empty set */
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT 0;

/* Returns all records */
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT NULL;

/* Using PostgreSQL LIMIT OFFSET to get top/bottom N rows*/
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
LIMIT 10;

SELECT film_id, title
FROM film
ORDER BY title
FETCH FIRST ROW ONLY;

SELECT film_id, title
FROM film
ORDER BY title
FETCH FIRST 1 ROW ONLY;

SELECT film_id, title
FROM film
ORDER BY title
FETCH FIRST 5 ROWS ONLY;

SELECT film_id, title
FROM film
ORDER BY title
OFFSET 5 ROWS
FETCH FIRST 5 ROWS ONLY;

/* Suppose you want to know the rental information of customer ID 1 and 2. */
SELECT
  customer_id,
  rental_id,
  return_date
FROM
  rental
WHERE
  customer_id IN (1, 2)
ORDER BY
  return_date DESC;