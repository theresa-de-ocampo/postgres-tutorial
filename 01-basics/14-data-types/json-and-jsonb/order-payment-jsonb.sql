SELECT
  SUM(wakuli_payment.body->>'amount')
FROM
  wakuli_order
INNER JOIN
  wakuli_payment
ON
  (wakuli_order.id)::TEXT = 
    ANY(
      SELECT
        jsonb_array_elements_text(wakuli_payment.body->'orders')
    )
WHERE
  wakuli_order.created_at BETWEEN '2022-12-01' AND '2022-12-31';


SELECT
  *
FROM
  wakuli_payment
WHERE
  'f8cfa500-19da-4246-8f79-1872f2f76ae2' = ANY(SELECT jsonb_array_elements_text(wakuli_payment.body->'orders'));