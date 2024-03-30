-- NUMERIC(precision, scale)
-- precision - total number of digits
-- scale - number of digits in the fraction part.

-- If you omit both precision and scale,
-- you can store any precision and scale up to Postgres' limit of precision and scale.
-- NUMERIC

-- If you store a value with a scale greater than the declared scale of the NUMERIC column,
-- Postgres will round the value to a specified number of fractional digits.

CREATE TABLE products(
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price NUMERIC(5, 2)
);

INSERT INTO products (name, price)
VALUES
  ('Phone', 500.215),
  ('Tablet', 500.214),
  ('Laptop', 600.215);


SELECT * FROM products;

-- Error
INSERT INTO products(name, price)
VALUES ('TV', 123456.21);

UPDATE products
SET price = 'NaN'
WHERE id = 1;

SELECT * FROM products ORDER BY price DESC;



