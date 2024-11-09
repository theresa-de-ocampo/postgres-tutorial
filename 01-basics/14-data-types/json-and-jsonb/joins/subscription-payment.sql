-- You can simply use the following.
SELECT
  *
FROM
  wakuli_payment
WHERE
  body->>'type' IN ('first', 'recurring') AND
  body @> '{"metadata": {"subscriptions": ["25bb8574-0a57-453f-8fc9-3738dba5b7c3"]}}' AND
  created_at >= '2024-05-01'
ORDER BY
  created_at;

-- *** But let's assume that order date != payment date.

-- [Error 1] Aggregate functions are not allowed in WHERE
WITH cte_orders AS (
  SELECT
    id
  FROM
    wakuli_order
  WHERE
    body @> '{"subscription": "25bb8574-0a57-453f-8fc9-3738dba5b7c3"}' AND
    created_at >= '2024-05-01'
  ORDER BY
    created_at
)
SELECT
  *
FROM
  wakuli_payment
WHERE
  EXISTS (
    SELECT
      1
    FROM
      cte_orders
    WHERE
      body->'orders' @> jsonb_agg(cte_orders.id)
  );
  

-- [Success 1] Ugly Use of Concat
WITH cte_orders AS (
  SELECT
    id
  FROM
    wakuli_order
  WHERE
    body @> '{"subscription": "25bb8574-0a57-453f-8fc9-3738dba5b7c3"}' AND
    created_at >= '2024-05-01'
  ORDER BY
    created_at
)
SELECT
  *
FROM
  wakuli_payment
WHERE
  EXISTS (
    SELECT
      1
    FROM
      cte_orders
    WHERE
      body->'orders' @> CONCAT('["', cte_orders.id, '"]')::jsonb
  );

-- [Error 2] Cannot cast type uuid to jsonb
-- This is a Postgres rule
WITH cte_orders AS (
  SELECT
    id
  FROM
    wakuli_order
  WHERE
    body @> '{"subscription": "25bb8574-0a57-453f-8fc9-3738dba5b7c3"}' AND
    created_at >= '2024-05-01'
  ORDER BY
    created_at
)
SELECT
  *
FROM
  wakuli_payment
WHERE
  EXISTS (
    SELECT
      1
    FROM
      cte_orders
    WHERE
      body->'orders' @> (cte_orders.id)::jsonb
  );

-- [Success 2] On the other hand, to_json would work since to_json is not a cast.
-- It's a conversion function similar to to_date() or to_char()
WITH cte_orders AS (
  SELECT
    id
  FROM
    wakuli_order
  WHERE
    body @> '{"subscription": "25bb8574-0a57-453f-8fc9-3738dba5b7c3"}' AND
    created_at >= '2024-05-01'
  ORDER BY
    created_at
)
SELECT
  *
FROM
  wakuli_payment
WHERE
  EXISTS (
    SELECT
      1
    FROM
      cte_orders
    WHERE
      body->'orders' @> to_jsonb(cte_orders.id)
  );
  