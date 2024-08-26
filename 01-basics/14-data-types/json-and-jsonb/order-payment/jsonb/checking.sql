-- CREATE DATABASE starbucks;

CREATE TABLE starbucks_order(
  id SERIAL PRIMARY KEY,
  body JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Some payments are not immediately punched per order.
CREATE TABLE starbucks_payment(
  id SERIAL PRIMARY KEY,
  body JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

INSERT INTO
  starbucks_order (body, created_at)
VALUES
  (
    '{"item": "Vanilla Sweet Cream Cold Brew", "size": "grande", "quantity": 1, "type": "single"}',
    '2024-07-05 08:00:00.000 +0000'
  ), -- payment 1
  (
    '{"item": "Iced Barista", "size": "tall", "quantity": 2, "type": "single"}',
    '2024-07-05 08:00:00.000 +0000'
  ), -- payment 1
  (
    '{"item": "Salted Caramel Cold Brew", "size": "venti", "quantity": 1, "type": "single"}',
    '2024-07-05 08:10:00.000 +0000'
  ), -- payment 2
  (
    '{"item": "Coffee Frappuccino", "size": "venti", "quantity": 1, "type": "single"}',
    '2024-07-05 08:10:00.000 +0000'
  ), -- payment 2
  (
    '{"item": "Ham & Cheese Croffle", "quantity": 1, "type": "single"}',
    '2024-07-05 08:10:00.000 +0000'
  ), -- payment 2
  (
    '{"item": "Breakfast Blend", "quantity": 2, "type": "recurring"}',
    '2024-07-06 09:00:00.000 +0000'
  ), -- payment 3
  (
    '{"item": "Ethiopia Blend", "quantity": 1, "type": "recurring"}',
    '2024-07-06 09:10:00.000 +0000'
  ), -- payment 4
  (
    '{"item": "Iced Chai Tea Latte", "size": "venti", "quantity": 1, "type": "single"}',
    '2024-08-20 08:00:00.000 +0000'
  ), -- payment 5
  (
    '{"item": "Strawberries & Cream Frappuccina", "size": "tall", "quantity": 1, "type": "single"}',
    '2024-08-20 08:10:00.000 +0000'
  ); -- payment 6
  
INSERT INTO
  starbucks_payment (body, created_at)
VALUES
  ('{"amount": 550, "orders": [1, 2]}', '2024-07-05 08:01:00.000 +0000'),
  ('{"amount": 650, "orders": [3, 4, 5]}', '2024-07-05 08:11:00.000 +0000'),
  ('{"amount": 1000, "orders": [6]}', '2024-07-20 09:01:00.000 +0000'),
  ('{"amount": 500, "orders": [7]}', '2024-07-20 09:11:00.000 +0000'),
  ('{"amount": 250, "orders": [8]}', '2024-08-20 08:01:00.000 +0000'),
  ('{"amount": 150, "orders": [9]}', '2024-08-20 08:11:00.000 +0000');

  
SELECT
  *
FROM
  starbucks_order;

SELECT
  *
FROM
  starbucks_payment;

-- Get revenue for July orders (PHP 2,700)
SELECT
  SUM((starbucks_payment.body->>'amount')::INT) AS revenue
FROM
  starbucks_payment
INNER JOIN LATERAL (
  SELECT (starbucks_payment.body->'orders'->>0)::INT AS id
) AS rs_order ON true
INNER JOIN
  starbucks_order ON rs_order.id = starbucks_order.id
WHERE
  starbucks_order.created_at BETWEEN '2024-07-01' AND '2024-07-31';

-- Get revenue for August orders (PHP 400)
SELECT
  SUM((starbucks_payment.body->>'amount')::INT) AS revenue
FROM
  starbucks_payment
INNER JOIN LATERAL (
  SELECT (starbucks_payment.body->'orders'->>0)::INT AS id
) AS rs_order ON true
INNER JOIN
  starbucks_order ON rs_order.id = starbucks_order.id
WHERE
  starbucks_order.created_at BETWEEN '2024-08-01' AND '2024-08-31';
