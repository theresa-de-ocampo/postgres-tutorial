-- To find the minimum value in a column of a table, you pass the name of the column to the MIN() function
-- The data type of the column can be number, string, or any comparable type
SELECT MIN(rental_rate)
FROM film ;

-- Using MIN in a subquery
-- Get films which have the lowest rental rate
SELECT
	film_id,
	title,
	rental_rate
FROM
	film 
WHERE 
	rental_rate = (
		SELECT MIN(rental_rate)
		FROM film
	) ;
	
