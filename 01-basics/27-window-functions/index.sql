CREATE TABLE product_group(
  group_id SERIAL PRIMARY KEY,
  group_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE product(
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(100) UNIQUE NOT NULL,
  price NUMERIC(8, 2) NOT NULL,
  group_id INT NOT NULL,
  CONSTRAINT fk_product_group_id FOREIGN KEY (group_id)
    REFERENCES product_group (group_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

INSERT INTO product_group (group_name)
VALUES
  ('Cellphone'),
  ('Laptop'),
  ('Tablet');
  
INSERT INTO product (product_name, price, group_id)
VALUES
  ('Microsoft Lumia', 200, 1),
  ('HTC One', 400, 1),
  ('Nexus', 500, 1),
  ('iPhone', 900, 1),
  ('HP Elite', 1200, 2),
  ('Lenovo Thinkpad', 700, 2),
  ('Sony VAIO', 700, 2),
  ('Dell Vostro', 800, 2),
  ('iPad', 700, 3),
  ('Kindle Fire', 150, 3),
  ('Samsung Galaxy Tab', 200, 3);

SELECT
  group_name,
  AVG(price) AS avg_price
FROM
  product_group
INNER JOIN
  product USING (group_id)
GROUP BY
  group_name;

/**
 * Similar to an aggregate function, a window function operates on a set of rows.
 * However, it does not reduce the number of rows returned by the query.
 * 
 * The term window describes the set of rows on which the window function operates.
 * A window function returns values from the rows in a window.
 */

/**
 * For instance, the following query returns the product name, the price, the product group,
 * along with the average prices of each product group.
 * 
 * In this query, the AVG() function works as a window function that operates on a set of rows
 * specified by the OVER clause. Each set of rows is called a window.
 */
SELECT
  product_name,
  price,
  group_name,
  AVG(price) OVER (
    PARTITION BY group_id
  ) AS avg_price
FROM
  product
INNER JOIN
  product_group USING (group_id);

/**
 * Note that a window function always performs the calculation on the result set after JOIN, WHERE,
 * GROUP BY, and HAVING clause
 */








