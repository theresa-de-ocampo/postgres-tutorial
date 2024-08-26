/*
 * The Postgres jsonb_array_elements function returns a set including all the top-level elements
 * in the JSONB array.
 * 
 * You can use the jsonb_array_elements function to expand a JSONB array into a set of rows,
 * each containing one element of the array.
 * 
 * It is a simpler option compared to complex looping logic.
 * It's also more efficient than executing the same operation on the application side by reducing
 * data transfer and processing overhead.
 * 
 * https://neon.tech/docs/functions/jsonb_array_elements
 * */

-- 1. BASIC EXAMPLE
SELECT jsonb_array_elements('[1, 2, [3, 4]]');

/**
 * Since the jsonb_array_elements() function return value is of type SETOF,
 * you can use jsonb_array_elements as a temporary table.
 */
SELECT * FROM jsonb_array_elements('[1, 2, [3, 4]]');

SELECT
  *
FROM
  jsonb_array_elements('[77, 85, 92, 95, 74, 79, 80, 97]') AS grades(grade)
WHERE
  CAST(grade AS INTEGER) > 85;

SELECT
  *
FROM
  jsonb_array_elements('[77, 85, 92, 95, 74, 79, 80, 97]') AS grade
WHERE
  CAST(grade AS INTEGER) > 85;


-- 2. ACCESSING ARRAY ELEMENTS
CREATE TABLE employee_14_demo (
  employee_id INT NOT NULL,
  body jsonb
);

INSERT INTO employee_14_demo VALUES
(1, '{"name": "Teriz", "hobbies": ["Netflix", "Jogging", "Coding"]}');

INSERT INTO employee_14_demo VALUES
(2, '{"name": "Deo", "hobbies": ["Gaming", "Movies", "Hiking"]}');

SELECT * FROM employee_14_demo;

UPDATE employee_14_demo
SET body = '{"name": "Teriz", "hobbies": ["Movies", "Jogging", "Coding"]}'
WHERE body->>'name' = 'Teriz';

SELECT DISTINCT 
  jsonb_array_elements_text(body->'hobbies') AS hobbies
FROM employee_14_demo;

SELECT DISTINCT 
  jsonb_array_elements(body->'hobbies') AS hobbies
FROM employee_14_demo;

SELECT
  employee_id,
  body
FROM
  employee_14_demo
WHERE
  body->'hobbies' @> '["Gaming"]';

SELECT employee_id, body FROM employee_14_demo WHERE body->'hobbies' @> '["Movies"]';

SELECT body->'hobbies' FROM employee_14_demo;

SELECT
  employee_id,
  body
FROM
  employee_14_demo
WHERE
  body->>'name' LIKE 'T%' ;
  

-- 3. SELECT TABLE + JSONB ARRAY
CREATE TABLE clothes (
  id SMALLINT,
  "name" VARCHAR(30),
  details JSONB
);

INSERT INTO clothes
VALUES
  (1, 'T-Shirt', '{"sizes": ["S", "M", "L", "XL"], "colors": ["Red", "Blue", "Green"]}'),
  (2, 'Jeans', '{"sizes": ["28", "30", "32", "34"], "colors": ["Blue", "Black"]}'),
  (3, 'Socks', '{"sizes": ["S", null, "L", "XL"], "colors": ["White", "Black", "Gray"]}');

SELECT * FROM clothes;

SELECT
  id,
  "name",
  "size"
FROM
  clothes,
  jsonb_array_elements(clothes.details->'sizes') AS "size"
WHERE
  "name" = 'Socks';


-- 4. ORDERING JSONB ARRAY ELEMENTS
CREATE TABLE workflow (
  id SERIAL PRIMARY KEY,
  title VARCHAR(50),
  steps JSONB
);

INSERT INTO
  workflow (title, steps)
VALUES
  (
    'Hiring',
    '{"tasks": ["Resume Screening", "Interview", "Background Check", "Technical Exam"]}'
  ),
  (
    'Project Development',
    '{"tasks": ["Requirement Analysis", "Design", "Implementation", "Testing", "Deployment"]}'
  ),
  (
    'Order Processing',
    '{"tasks": ["Order Received", "Payment Verification", "Packing", "Shipment", "Delivery"]}'
  );

SELECT
  *
FROM
  workflow;

SELECT
  title,
  task.value AS task_name,
  task.ORDINALITY AS task_order
FROM
  workflow,
  jsonb_array_elements_text(steps->'tasks') WITH ORDINALITY AS task;


-- 5. NESTED ARRAYS
CREATE TABLE electronic_product (
  id SMALLINT PRIMARY KEY,
  "name" VARCHAR(70),
  details JSONB
);

SELECT
  *
FROM
  electronic_product;

INSERT INTO
  electronic_product
VALUES
  (
    1, 
    'Laptop',
    '{
      "variants": [
        {
          "model": "A",
          "sizes": ["13 inch", "15 inch"],
          "colors": ["Silver", "Black"]
        },
        {
          "model": "B",
          "sizes": ["15 inch", "17 inch"],
          "colors": ["Gray", "White"]
        }
      ]
    }'
  ),
  (
    2,
    'Smartphone',
    '{
      "variants": [
        {
          "model": "X",
          "sizes": ["5.5 inch", "6 inch"],
          "colors": ["Black", "Gold"]
        },
        {
          "model": "Y",
          "sizes": ["6.2 inch", "6.7 inch"],
          "colors": ["Blue", "Red"]
        }
      ]
    }'
  );

SELECT
  *
FROM
  electronic_product;

SELECT
  "name",
  variant->>'model' AS model,
  "size",
  color
FROM
  electronic_product,
  jsonb_array_elements(details->'variants') AS variant,
  jsonb_array_elements_text(variant->'sizes') AS sizes("size"),
  jsonb_array_elements_text(variant->'colors') AS colors(color);


-- 6. JOINS

/**
 * Let's assume you want to retrieve a list of users along with their roles in each organization.
 */

CREATE TABLE "organization" (
  id SERIAL PRIMARY KEY,
  members JSONB
);

CREATE TABLE "user" (
  id INTEGER PRIMARY KEY,
  "name" VARCHAR(70),
  "email" VARCHAR(70)
);

INSERT INTO
  "organization" (members)
VALUES
  ('[ { "id": 23, "role": "admin" }, { "id": 24, "role": "default" } ]'),
  ('[ { "id": 23, "role": "user"} ]'),
  ('[ { "id": 24, "role": "admin" }, { "id": 25, "role": "default"} ]'),
  ('[ { "id": 25, "role": "user"} ]');

INSERT INTO
  "user" (id, "name", "email")
VALUES
  (23, 'Max', 'max@gmail.com'),
  (24, 'Joe', 'joe@gmail.com'),
  (25, 'Alice', 'alice@gmail.com');

SELECT * FROM "organization";

--SELECT
--  "organization".id AS organization_id,
--  "user".id AS user_id,
--  "user"."name" AS user_name,
--  "user".email AS user_email,
--  "member"."role" AS member_role
--FROM
--  "organization",
--  jsonb_array_elements("organization".members) AS members("member")
--INNER JOIN
--  "user" ON "member".id = "user".id;

SELECT
  "organization".id AS organization_id,
  "user".id AS user_id,
  "user"."name" AS user_name,
  "user".email AS user_email,
  "member"->>'role' AS member_role
FROM
  "organization"
INNER JOIN
  jsonb_array_elements("organization".members) AS members("member") ON TRUE
INNER JOIN
  "user" ON "member"->>'id' = CAST("user".id AS TEXT);

/**
 * Use jsonb_array_elements when you need to maintain the JSON structure of the elements for further
 * JSON-related operations or analysis and jsonb_array_elements_text if you need to work with
 * extracted elements as plain text for string operations, text analysis, or integration with
 * text-based functions.
 */
















  
  
