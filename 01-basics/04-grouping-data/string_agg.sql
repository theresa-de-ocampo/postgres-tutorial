/**
 * The PostgreSQL STRING_AGG() is an aggregate function that concatenates a list of strings and
 * places a separator between them. It does not add the separator at the end of the string.
 * 
 * STRING_AGG(expression, separator [ORDER BY clause])
 * 
 * expression is any valid expression that can resolve to a character string.
 * If you use other types than character string type, you need to explicitly cast these values.
 * 
 * The STRING_AGG() is similar to the ARRAY_AGG() function except for the return type.
 * The return value of STRING_AGG() function is a string, whereas the return value of ARRAY_AGG()
 * is an array.
 * 
 * Like other aggregate functions such as AVG(), COUNT(), MAX(), MIN(), and SUM(), the STRING_AGG()
 * function is often used with the GROUP BY clause.
 */

/**
 * special_features column has a type of _text.
 * It's an internal type name for an array. Similar to int8 being an internal name for bigint.
 * special_features _text is the same as special_features TEXT[].
 * In other words, array types are identified with the _ prefix in pg_type.
 */
SELECT
  *
FROM
  film;

SELECT  
  *
FROM
  film_actor;

SELECT
  *
FROM
  actor;

-- Return a list of actor's names for each film
SELECT
  film.title AS title,
  STRING_AGG(
    CONCAT(TRIM(actor.first_name), ' ', TRIM(actor.last_name)),
    ', '
    ORDER BY
      actor.last_name,
      actor.first_name
  )
FROM
  film
INNER JOIN
  film_actor USING (film_id)
INNER JOIN
  actor USING (actor_id)
GROUP BY
  film.title
ORDER BY
  title;


-- Build an email list for each country
SELECT
  *
FROM
  customer;

SELECT
  *
FROM
  address;

SELECT
  *
FROM
  city;

SELECT
  *
FROM
  country;

SELECT
  country.country AS country,
  STRING_AGG(
    customer.email,
    '; '
    ORDER BY customer.email
  )
FROM
  customer
INNER JOIN
  address USING (address_id)
INNER JOIN
  city USING(city_id)
INNER JOIN
  country USING(country_id)
GROUP BY
  country.country
ORDER BY
  country;




SELECT 10;