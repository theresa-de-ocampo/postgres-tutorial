CREATE TABLE "order" (
  order_id SERIAL PRIMARY KEY,
  user_id INTEGER,
  created_at TIMESTAMP NOT NULL
);

INSERT INTO "order" (user_id, created_at)
VALUES 
  (1, '2022-12-25 08:00:00'),
  (2, '2022-12-25 08:15:00'),
  (3, '2022-12-25 08:30:00'),
  (1, '2023-08-29 08:00:00'),
  (3, '2023-08-29 09:00:00'),
  (3, '2023-08-29 09:15:00') ;

SELECT user_id,
       first_order_time,
       next_order_time
FROM   (SELECT user_id,
               First_value(created_at)
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at) AS first_order_time,
               Nth_value(created_at, 2)
                 over(
                   PARTITION BY user_id
                   ORDER BY created_at) AS next_order_time,
               Rank()
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at DESC) AS rnk
        FROM   "order") T
WHERE  T.rnk = 1 ;



SELECT user_id,
       first_order_time,
       next_order_time
FROM   (SELECT user_id,
               First_value(created_at)
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at) AS first_order_time,
               Nth_value(created_at, 2)
                 over(
                   PARTITION BY user_id
                   ORDER BY created_at) AS next_order_time
        FROM   "order") AS t;



SELECT *
FROM   (SELECT user_id,
               First_value(created_at)
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at) AS first_order_time,
               Lead(created_at)
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at) AS next_order_time,
               Lead(user_id)
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at) AS id,
               Row_number()
                 over (
                   PARTITION BY user_id
                   ORDER BY created_at) AS last_order
        FROM   "order") t
WHERE  last_order = 1 ;


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
      "order" 
    GROUP BY
      user_id
  ) order1
LEFT JOIN LATERAL 
  (
    SELECT 
      order_id second_order_id,
      created_at second_order_time
    FROM
      "order" 
    WHERE 
      user_id = order1.user_id AND
      created_at > order1.first_order_time
    ORDER BY created_at ASC LIMIT 1
  ) order2 ON TRUE
ORDER BY
  user_id;





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
      "order" 
    GROUP BY
      user_id
  ) order1
LEFT JOIN LATERAL 
  (
    SELECT 
      order_id second_order_id,
      created_at second_order_time
    FROM
      "order" 
    WHERE 
      user_id = order1.user_id AND
      created_at > order1.first_order_time
    ORDER BY created_at ASC LIMIT 1
  ) order2 ON TRUE
ORDER BY
  user_id;



SELECT
  first_orders.user_id,
  first_orders.first_order_time,
  second_order_time,
  second_order_id
FROM
  (
    SELECT
      user_id,
      MIN(created_at) AS first_order_time
    FROM
      "order"
    GROUP BY
      user_id
  ) AS first_orders
LEFT JOIN
  (
    SELECT
      user_id,
      created_at AS first_order_time,
      (
        SELECT
          created_at
        FROM
          "order" AS inner_order_1
        WHERE
          inner_order_1.user_id = outer_order.user_id AND 
          created_at > outer_order.created_at
        ORDER BY
          created_at LIMIT 1
      ) AS second_order_time,
      (
        SELECT
          order_id
        FROM
          "order" AS inner_order_2
        WHERE
          inner_order_2.user_id = outer_order.user_id AND 
          created_at > outer_order.created_at
        ORDER BY
          created_at LIMIT 1
      ) AS second_order_id
    FROM
      "order" outer_order
  ) AS second_orders
ON
  first_orders.user_id = second_orders.user_id AND
  first_orders.first_order_time = second_orders.first_order_time;





-- aight



SELECT 
    order1.user_id,
    order1.first_order_time,
    order2.second_order_time,
    order2.second_order_id
FROM (
    SELECT 
        user_id,
        MIN(created_at) AS first_order_time
    FROM 
        "order"
    GROUP BY 
        user_id
) AS order1
LEFT JOIN (
    SELECT 
        ol1.user_id,
        ol1.created_at AS first_order_time,
        (
            SELECT 
                MIN(ol2.created_at)
            FROM 
                "order" AS ol2
            WHERE 
                ol2.user_id = ol1.user_id
                AND ol2.created_at > ol1.created_at
        ) AS second_order_time,
        (
            SELECT 
                ol2.order_id
            FROM 
                "order" AS ol2
            WHERE 
                ol2.user_id = ol1.user_id
                AND ol2.created_at > ol1.created_at
            ORDER BY 
                ol2.created_at
            LIMIT 1
        ) AS second_order_id
    FROM 
        "order" AS ol1
) AS order2 ON order1.user_id = order2.user_id AND order1.first_order_time = order2.first_order_time;



-- chos
SELECT
  user_id,
  (
    SELECT
      MIN(created_at)
    FROM
      "order"
    WHERE
      user_id = outer_order.user_id
  ) AS first_order_time,
  (
    SELECT
      created_at
    FROM
      "order"
    WHERE
      user_id = outer_order.user_id AND
      created_at > (SELECT MIN(created_at) FROM "order"
    ORDER BY
      created_at
    LIMIT 1
  ) AS second_order_time,
  (
    SELECT
      order_id
    FROM
      "order"
    WHERE
      user_id = outer_order.user_id AND
      created_at > MIN(created_at)
    ORDER BY
      created_at
    LIMIT 1
  ) AS second_order_id
FROM
  "order" AS outer_order
GROUP BY
  user_id;





  
  