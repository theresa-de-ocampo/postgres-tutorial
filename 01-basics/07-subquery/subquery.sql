SELECT
  film_id,
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate > (
    SELECT AVG(rental_rate) FROM film
  );

SELECT * FROM rental;
SELECT * FROM inventory;

-- Get the films that have the returned date between 2005-05-29 and 2005-05-30
SELECT
  inventory.film_id
FROM
  rental
INNER JOIN
  inventory ON inventory.inventory_id = rental.inventory_id
WHERE
  return_date BETWEEN '2005-05-29' AND '2005-05-30';

-- Subquery with IN operator
SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id IN (
    SELECT
      inventory.film_id
    FROM
      rental
    INNER JOIN
      inventory ON inventory.inventory_id = rental.inventory_id
    WHERE
      return_date BETWEEN '2005-05-29' AND '2005-05-30'
  );

-- Subquery with EXISTS operator
/**
 * A subquery can be an input of the EXISTS operator.
 * If the subquery returns any row, the EXISTS operator returns true.
 * If the subquery returns no row, the result of EXISTS operator is false.
 * 
 * The exists operator only cares about the number of rows returned from the subquery,
 * not the content of the rows, therefore, the common coding convention of EXISTS is:
 * EXISTS (SELECT 1 FROM table WHERE condition)
 */
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  EXISTS (
    SELECT
      1
    FROM
      payment
    WHERE
      payment.customer_id = customer.customer_id
  );

-- The query works like an INNER JOIN on the customer_id.
-- However, it returns at most one row for each row in the customer table,
-- even though there may be some more corresponding rows in the payment table.
  








