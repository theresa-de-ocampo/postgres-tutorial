-- https://medium.com/kkempin/postgresqls-lateral-join-bfd6bd0199df

CREATE TABLE order_l (
	order_id SERIAL PRIMARY KEY,
	user_id INTEGER,
	created_at TIMESTAMP NOT NULL
) ;

INSERT INTO order_l (user_id, created_at)
VALUES 
	(1, '2017-06-20 04:35:03.582895'),
	(2, '2017-06-20 04:35:07.564973'),
	(3, '2017-06-20 04:35:10.986712'),
	(1, '2017-06-20 04:58:10.137503'),
	(3, '2017-06-20 04:58:17.905277'),
	(3, '2017-06-20 04:58:25.289122') ;
	
SELECT * FROM order_l ;

/*
 * The official documentation has a fancy definition for the LATERAL keyword.
 * But you can think of it like this: iterate over each of the results (records),
 * and run subquery giving an access to that record.
 */

-- OBJECTIVE: Get the following
-- time of the first order created by each user
-- ID and time of the next order
SELECT 
	user_id,
	first_order_time,
	second_order_time,
	second_order_id
FROM
	(
		SELECT
			user_id,
			MIN(created_at) first_order_time
		FROM
			order_l 
		GROUP BY
			user_id
	) order1
LEFT JOIN LATERAL 
	(
		SELECT 
			order_id second_order_id,
			created_at second_order_time
		FROM
			order_l 
		WHERE 
			user_id = order1.user_id AND
			created_at > order1.first_order_time
		ORDER BY created_at ASC LIMIT 1
	) order2 ON true ;


/*
 * ON true because you want each right-hand side subquery to be evaluated once
 * for each row of the left-hand side table.
 * 
 * If you remove the ON true, you'll get:
 * SQL Error [42601]: ERROR: syntax error at end of input
 * 
 * This is because in Postgres, the JOIN clause must be terminated by either an
 * ON clause, a USING clause, or a WHERE clause. In a LATERAL JOIN, the ON clause
 * is often specified as "ON true" to indicate that there is no specific JOIN 
 * condition, but the clause itself is still required to terminate the JOIN clause.
 */

/**
 * You also can't really use USING (user_id) cause it will execute the sub-query
 * first. Which means, it will get records passing created_at > order1.first_order_time.
 * It then limits it to just 1 record, which likely does not have the same user_id
 * as the LH query. In such cases, it will just return null since it did not pass
 * USING (user_id).
 */

-- INCORRECT IMPLEMENTATION
--SELECT 
--	user_id,
--	first_order_time,
--	second_order_time,
--	second_order_id
--FROM
--	(
--		SELECT
--			user_id,
--			MIN(created_at) first_order_time
--		FROM
--			order_l 
--		GROUP BY
--			user_id
--	) order1
--LEFT JOIN LATERAL 
--	(
--		SELECT 
--			order_id second_order_id,
--			created_at second_order_time,
--			user_id 
--		FROM
--			order_l 
--		WHERE 
--			created_at > order1.first_order_time
--		ORDER BY created_at ASC LIMIT 1
--	) order2 USING (user_id) ;

/*
 * User with an ID of 2, only ordered once.
 * We could use INNER JOIN LATERAL instead to consider only those rows which
 * have corresponding rows in the second table.
 */
SELECT 
	user_id,
	first_order_time,
	second_order_time,
	second_order_id
FROM
	(
		SELECT
			user_id,
			MIN(created_at) first_order_time
		FROM
			order_l 
		GROUP BY
			user_id
	) order1
INNER JOIN LATERAL 
	(
		SELECT 
			order_id second_order_id,
			created_at second_order_time
		FROM
			order_l 
		WHERE 
			user_id = order1.user_id AND
			created_at > order1.first_order_time
		ORDER BY created_at ASC LIMIT 1
	) order2 ON true ;

/*
 * Your approach to the problem:
 * You were trying to sort the created_at of each user,
 * and then from there, you were trying to get the top 2 
 */
--SELECT 
--	user_id,
--	created_at AS first_order_time,
--	created_at AS second_order_time,
--	order_id AS second_order_id
--FROM
--	order_l 
--GROUP BY user_id ;
	
-- Other sample scenario for LATERAL JOIN: conversions
-- https://www.heap.io/blog/postgresqls-powerful-new-join-type-lateral
	