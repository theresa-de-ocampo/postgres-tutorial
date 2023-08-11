SELECT
  customer_id,
  SUM(amount)
FROM
  payment
GROUP BY
  customer_id;

SELECT
  customer_id,
  SUM (amount) total_payment
FROM
  payment
GROUP BY
  customer_id
HAVING
  SUM (amount) > 200;