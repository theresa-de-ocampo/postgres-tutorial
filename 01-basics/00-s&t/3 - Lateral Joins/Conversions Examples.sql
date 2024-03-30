CREATE TABLE user_event(
  event_id SERIAL PRIMARY KEY,
  user_id SMALLINT NOT NULL,
  event_name VARCHAR(50) NOT NULL,
  event_timestamp TIMESTAMP NOT NULL,
  event_parameters JSONB
);

INSERT INTO user_event (user_id, event_name, event_timestamp, event_parameters)
VALUES
  (1, 'page_view', '2023-07-05 08:00:00','{"search": "nike react shoes"}'),
  (1, 'add_to_cart', '2023-07-05 08:30:00', '{"platform_voucher": "free_shipping"}'),
  (1, 'purchase', '2023-07-07 08:35:00', '{"amount": 5999, "payment_method": "paypal"}'),
  (2, 'page_view', '2023-08-01 09:00:00', '{"search": "nike air max shoes"}'),
  (3, 'page_view', '2023-08-01 10:00:00', '{"search": "basketball shoes"}'),
  (3, 'add_to_cart', '2023-09-09 12:00:00', NULL),
  (3, 'purchase', '2023-09-09 12:30:00', '{"amount": 7999, "payment_method": "google_pay"}');
  
SELECT * FROM user_event ORDER BY user_id;

-- Get customer conversions
-- user_id, view_homepage_time, purchase_time, purchase_amount

-- LATERAL JOIN

SELECT
  user_id,
  page_view_time,
  purchase_time,
  purchase_amount
FROM
  (
    SELECT
      user_id,
      MIN(event_timestamp) AS page_view_time
    FROM
      user_event
    WHERE
      event_name = 'page_view'
    GROUP BY
      user_id
  ) page_view
LEFT JOIN LATERAL
  (
    SELECT
      event_timestamp AS purchase_time,
      event_parameters->>'amount' AS purchase_amount
    FROM
      user_event
    WHERE
      user_id = page_view.user_id AND 
      event_name = 'purchase' AND
      event_timestamp BETWEEN page_view_time AND (page_view_time + INTERVAL '2 weeks')
  ) purchase ON TRUE
ORDER BY
  user_id;


-- CORRELATED SUBQUERY
SELECT
  u.user_id,
  (
    SELECT MIN(event_timestamp)
    FROM user_event
    WHERE user_id = u.user_id
      AND event_name = 'page_view'
  ) AS page_view_time,
  (
    SELECT event_timestamp
    FROM user_event
    WHERE user_id = u.user_id
      AND event_name = 'purchase'
      AND event_timestamp BETWEEN (
        SELECT MIN(event_timestamp)
        FROM user_event
        WHERE user_id = u.user_id
          AND event_name = 'page_view'
      ) AND (
        SELECT MIN(event_timestamp)
        FROM user_event
        WHERE user_id = u.user_id
          AND event_name = 'page_view'
      ) + INTERVAL '2 weeks'
    LIMIT 1
  ) AS purchase_time,
  (
    SELECT (event_parameters->>'amount')::NUMERIC
    FROM user_event
    WHERE user_id = u.user_id
      AND event_name = 'purchase'
      AND event_timestamp BETWEEN (
        SELECT MIN(event_timestamp)
        FROM user_event
        WHERE user_id = u.user_id
          AND event_name = 'page_view'
      ) AND (
        SELECT MIN(event_timestamp)
        FROM user_event
        WHERE user_id = u.user_id
          AND event_name = 'page_view'
      ) + INTERVAL '2 weeks'
    LIMIT 1
  ) AS purchase_amount
FROM (
  SELECT DISTINCT user_id
  FROM user_event
) AS u
ORDER BY u.user_id;









