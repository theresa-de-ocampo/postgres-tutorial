/**
 * A natural join is a join that creates an implicit join based on the same column names
 * in the joined tables.
 * 
 * A natural join can be an inner join, left join, or right join.
 * If you do not specify a JOIN explicitly, Postgres will use INNER JOIN by default.
 * 
 * If you use the asterisk in the select list, the result will contain the following columns:
 *    (1) All the common columns, which are columns from both tables that have the same name.
 *    (2) Every column from both tables, which is not a common column. 
 */

CREATE TABLE category_03_demo (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(70) NOT NULL
);

CREATE TABLE product_03_demo (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(70) NOT NULL,
  category_id INT NOT NULL,
  CONSTRAINT fk_product_category_id FOREIGN KEY (category_id)
    REFERENCES category_03_demo (category_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

INSERT INTO category_03_demo (category_name)
VALUES
  ('Smart Phone'),
  ('Laptop'),
  ('Tablet');

INSERT INTO product_03_demo (product_name, category_id)
VALUES
  ('iPhone', 1),
  ('Samsung Galaxy', 1),
  ('HP Probook', 2),
  ('Lenovo Thinkpad', 2),
  ('iPad', 3),
  ('Kindle Fire', 3);
