CREATE OR REPLACE FUNCITON get_rental_duration(p_customer_id INT)
  RETURNS INT
  LANGUAGE plpgsql
AS $$
  DECLARE rental_duration INT;

  BEGIN
    SELECT
      SUM(return_date - rental_date)
    INTO
      retal_duration
    FROM
      rental
    WHERE
      customer_id = 318;
  END;
$$;

SELECT
  *
FROM
  rental
WHERE
  customer_id = 318;
  
SELECT
  SUM(return_date - rental_date)
FROM
  rental
WHERE
  customer_id = 318;
      
SELECT
  customer_id,
  COUNT(rental_id) AS number_of_rentals
FROM
  rental
GROUP BY
  customer_id
ORDER BY
  number_of_rentals;