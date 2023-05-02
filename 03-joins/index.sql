CREATE TABLE basket_a (
  id INT PRIMARY KEY,
  fruit VARCHAR(100) NOT NULL
);

CREATE TABLE basket_b (
  id INT PRIMARY KEY,
  fruit VARCHAR(100) NOT NULL
);

INSERT INTO basket_a (id, fruit)
VALUES
  (1, 'Apple'),
  (2, 'Orange'),
  (3, 'Banana'),
  (4, 'Cucumber');

INSERT INTO basket_b (id, fruit)
VALUES
  (1, 'Orange'),
  (2, 'Apple'),
  (3, 'Watermelon'),
  (4, 'Pear');

SELECT
  basket_a.id,
  basket_a.fruit,
  basket_b.id,
  basket_b.fruit
FROM
  basket_a
INNER JOIN basket_b
  ON basket_a.fruit = basket_b.fruit;

/* Note that the LEFT JOIN is the same as the LEFT OUTER JOIN, so you can use them interchangeably. */
SELECT
  basket_a.id,
  basket_a.fruit,
  basket_b.id,
  basket_b.fruit
FROM
  basket_a
LEFT JOIN basket_b
  ON basket_a.fruit = basket_b.fruit;

/* Select rows from the left table that do not have matching rows in the right table. */
SELECT
  basket_a.id,
  basket_a.fruit,
  basket_b.id,
  basket_b.fruit
FROM
  basket_a
LEFT JOIN basket_b
  ON basket_a.fruit = basket_b.fruit
WHERE
  basket_b.id IS NULL;

SELECT
  basket_a.id,
  basket_a.fruit,
  basket_b.id,
  basket_b.fruit
FROM
  basket_a
FULL OUTER JOIN basket_b
  ON basket_a.fruit = basket_b.fruit;

/* FULL OUTER JOIN - only rows unique to both tables */
SELECT
  basket_a.id,
  basket_a.fruit,
  basket_b.id,
  basket_b.fruit
FROM
  basket_a
FULL OUTER JOIN basket_b
  ON basket_a.fruit = basket_b.fruit
WHERE
  basket_a.id IS NULL OR basket_b.id IS NULL;


DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS employee;

CREATE TABLE department (
  department_id SERIAL PRIMARY KEY,
  department_name VARCHAR(255) NOT NULL
);

CREATE TABLE employee (
  employee_id SERIAL PRIMARY KEY,
  employee_name VARCHAR(255),
  department_id INTEGER
);

INSERT INTO department (department_name)
VALUES
  ('Sales'),
  ('Marketing'),
  ('HR'),
  ('IT'),
  ('Production');

INSERT INTO employee (employee_name, department_id)
VALUES
  ('Bette Nicholson', 1),
  ('Christian Gable', 1),
  ('Joe Swank', 2),
  ('Teriz De Ocampo', 3),
  ('Sandra Kilmer', 4);

SELECT
  employee_name,
  department_name
FROM
  employee
FULL OUTER JOIN department
  ON department.department_id = employee.department_id;

SELECT
  department_name
FROM
  department
LEFT JOIN employee
  ON department.department_id = employee.department_id
WHERE
  employee.department_id IS NULL;

SELECT
  department_name,
  department.department_id,
  employee.department_id
FROM
  department
FULL OUTER JOIN employee
  ON department.department_id = employee.department_id
WHERE
  employee.department_id IS NULL;
 
ALTER TABLE employee RENAME TO employee;
ALTER TABLE department RENAME TO department;
  
 
 
