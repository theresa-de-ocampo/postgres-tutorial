SELECT * FROM film LIMIT 100 ; 

WITH cte_film AS (
	SELECT
		film_id,
		title,
		CASE
			WHEN length < 30 THEN 'Short'
			WHEN length < 90 THEN 'Medium'
			ELSE 'Long'
		END length
	FROM
		film 
)
SELECT
	film_id,
	title,
	length
FROM
	cte_film
WHERE 
	length = 'Long'
ORDER BY
	title ;

-- Joining a CTE with a table
SELECT * FROM rental LIMIT 100 ;

WITH cte_rental AS (
	SELECT
		staff_id,
		COUNT(rental_id) rental_count
	FROM
		rental 
	GROUP BY
		staff_id 
)
SELECT 
	staff_id,
	first_name,
	last_name,
	rental_count
FROM
	staff 
INNER JOIN cte_rental
	USING (staff_id) ;

-- TODO: Using CTE with a window function
	
SELECT * FROM staff;

 SELECT staff_id,
        COUNT(rental_id) rental_count
    FROM   rental
    GROUP  BY staff_id
    
SELECT
  count(rental_id) rental_count,
  first_name,
  last_name
FROM
  rental
INNER JOIN
  staff USING (staff_id)
GROUP BY
  staff_id;

SELECT * FROM rental;










