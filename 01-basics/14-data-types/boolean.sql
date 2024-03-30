CREATE TABLE stock_availability(
  product_id INT PRIMARY KEY,
  available BOOLEAN NOT NULL
);

INSERT INTO
  stock_availability
VALUES
  (100, true),
  (200, false),
  (300, 't'),
  (400, '1'),
  (500, 'y'),
  (600, 'yes'),
  (700, 'no'),
  (800, '0');

SELECT *
FROM stock_availability
WHERE available = 'yes';

-- You can imply the value by using the Boolean column without any operator.
SELECT *
FROM stock_availability
WHERE available;

SELECT *
FROM stock_availability
WHERE NOT available;

