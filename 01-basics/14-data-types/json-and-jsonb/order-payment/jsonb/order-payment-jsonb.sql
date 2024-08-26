-- APPROACH 1: Sequential Scan
-- If orders is NOT a jsonb ARRAY but a TEXT[] instead, then ANY will be the only solution. 
EXPLAIN ANALYZE
SELECT
  *
FROM
  wakuli_payment
WHERE
  'e82b1a22-e44f-42df-a38f-f845c0ebb647' = 
    ANY(SELECT jsonb_array_elements_text(wakuli_payment.body->'orders'));

  
-- APPROACH 2: Bitmap Heap Scan
EXPLAIN ANALYZE
SELECT
  *
FROM
  wakuli_payment
WHERE
  body->'orders' ? 'e82b1a22-e44f-42df-a38f-f845c0ebb647';

-- APPROACH 3: Bitmap Heap Scan
-- Has lower execution time on average
-- The @> operator is generally more efficient for JSONB containment queries.
-- The @> operator checks which records have a specifc structure specified by the query.
-- Whereas, the ? operator checks which wakuli_payment.body->'orders' contain a specific element.
-- They differ in the Indec Condition.
EXPLAIN ANALYZE
SELECT
  *
FROM
  wakuli_payment
WHERE
  body @> '{"orders": ["e82b1a22-e44f-42df-a38f-f845c0ebb647"]}';



-- Get total revenue of orders created on a given period
SELECT
  SUM((wakuli_payment.body->'amount'->>'value')::NUMERIC)
FROM
  wakuli_payment
INNER JOIN LATERAL (
  SELECT
    wakuli_payment.body->'orders'->>0 AS id
) AS rs_order ON TRUE
INNER JOIN
  wakuli_order ON (wakuli_order.id)::TEXT = rs_order.id
WHERE
  wakuli_payment.body @> '{"state": "paid"}' AND
  wakuli_order.created_at BETWEEN '2022-12-01' AND '2022-12-31';

SELECT
  *
FROM
  wakuli_payment
ORDER BY
  created_at DESC;




  

