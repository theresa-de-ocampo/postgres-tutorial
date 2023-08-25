CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE royal_order (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  item VARCHAR(70) NOT NULL,
  quantity SMALLINT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE royal_payment (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  orders UUID[] NOT NULL,
  status CHAR(20) NOT NULL DEFAULT 'unverified',
  payment_method VARCHAR(50) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

INSERT INTO royal_order (item, quantity)
VALUES
  ('steak', 1),
  ('pepsi', 1),
  ('fried chicken', 2),
  ('sprite', 2),
  ('salad', 1);

SELECT * FROM royal_order;

INSERT INTO royal_payment (orders, status, payment_method)
VALUES
  (
    ARRAY[
      'fcc6ec2a-160e-4e77-adb8-98584cb052d9'::UUID,
      '47ec14b7-219a-4414-8297-7eef0280a798'::UUID
    ],
    'paid',
    'gcash'
  ),
  (
    ARRAY[
      '70324231-92c3-4510-bbc8-4d6202648d25'::UUID,
      '57745b67-20ec-4ce3-bb75-afb15454e4ef'::UUID,
      'b3aab551-b5f1-4d87-afb0-b4eef2c12503'::UUID
    ],
    'paid',
    'gcash'
  );

SELECT * FROM royal_payment;

SELECT
  id,
  status,
  payment_method,
  UNNEST(orders)
FROM
  royal_payment;

SELECT
  UNNEST(orders)
FROM
  royal_payment;

SELECT
  *
FROM
  royal_order
INNER JOIN
  (
    SELECT
      id,
      status,
      payment_method,
      UNNEST(orders) AS order_id
    FROM
      royal_payment
  ) AS royal_payment
ON
  royal_order.id = royal_payment.order_id;


