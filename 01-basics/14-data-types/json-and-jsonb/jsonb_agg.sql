/**
 * Creates a JSON array from data of multiple rows.
 * Aggregates values into a JSON array.
 */


-- 1. BASIC EXAMPLE
SELECT
  *
FROM
  product;
  
SELECT
  jsonb_agg(
    jsonb_build_object(
      'product_name', product_name,
      'price', price
    )
  )
FROM
  product;
  
-- 2. WITH GROUP BY
SELECT
  *
FROM
  department;
  
SELECT
  *
FROM
  employee;

DROP TABLE IF EXISTS employee;

CREATE TABLE employee(
  employee_id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  birthday DATE NOT NULL,
  hire_date DATE NOT NULL,
  department_id INT NOT NULL,
  CONSTRAINT fk_employee_department_id FOREIGN KEY (department_id)
    REFERENCES department (department_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

INSERT INTO
  employee (first_name, last_name, birthday, hire_date, department_id)
VALUES
  ('Teriz', 'De Ocampo', '1999-11-07', '2022-09-05', 4),
  ('Shannon', 'Freeman', '1980-01-01', '2005-01-01', 2),
  ('Ethel', 'Webb', '1975-01-01', '2001-01-01', 5),
  ('Edzer', 'Padilla', '1994-03-31', '2020-07-01', 4),
  ('Ghiannine', 'Go', '1997-02-17', '2021-04-03', 4),
  ('Grant', 'MacLaren', '1980-11-26', '2019-05-25', 2);

SELECT
  department.department_name AS department_name,
  jsonb_agg(CONCAT(employee.first_name, ' ', employee.last_name) ORDER BY employee.last_name)
FROM
  employee
INNER JOIN
  department USING (department_id)
GROUP BY
  department.department_name
ORDER BY
  department_name;

-- 3. WITH NULLS
-- HR and Sales have no employees, hence, jsonb_agg returns an array that contains a null value.
SELECT
  department.department_name AS department_name,
  jsonb_agg(employee.last_name ORDER BY employee.last_name)
FROM
  employee
RIGHT JOIN
  department USING (department_id)
GROUP BY
  department.department_name
ORDER BY
  department_name;

-- To skip the null and turn it into an empty array, use COALESCE + FILTER
-- https://stackoverflow.com/questions/24155190/postgresql-left-join-json-agg-ignore-remove-null
SELECT
  department.department_name AS department_name,
  COALESCE(
    jsonb_agg(employee.last_name ORDER BY employee.last_name)
      FILTER(WHERE employee.last_name IS NOT NULL), '[]'
  ) AS members
FROM
  employee
RIGHT JOIN
  department USING (department_id)
GROUP BY
  department.department_name
ORDER BY
  department_name;





