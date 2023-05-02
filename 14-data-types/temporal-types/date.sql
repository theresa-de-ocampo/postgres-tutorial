CREATE TABLE document(
  document_id SERIAL PRIMARY KEY,
  header_text VARCHAR(255) NOT NULL,
  posting_date DATE DEFAULT CURRENT_DATE NOT NULL 
);

INSERT INTO document(header_text)
VALUES ('Billing to customer XYZ');

SELECT * FROM "document";

-- *** Postgres Date Functions **
DROP TABLE IF EXISTS employee;

CREATE TABLE employee(
  employee_id SERIAL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  birthday DATE NOT NULL,
  hire_date DATE NOT NULL
);

INSERT INTO
  employee (first_name, last_name, birthday, hire_date)
VALUES
  ('Teriz', 'De Ocampo', '1999-11-07', '2022-09-05'),
  ('Shannon', 'Freeman', '1980-01-01', '2005-01-01'),
  ('Ethel', 'Webb', '1975-01-01', '2001-01-01');

SELECT NOW();
SELECT NOW()::DATE;
SELECT CURRENT_DATE;

-- To output a date value into a specific format, you use TO_CHAR
-- This function accepts two arguments:
--  (1) The value that you want to format.
--  (2) The template that defines the output format.
SELECT TO_CHAR(CURRENT_DATE, 'dd/mm/yyyy');
SELECT TO_CHAR(CURRENT_DATE, 'Mon dd, yyyy');

-- To get the interval between two dates, you use the minus operator.
-- Get the service days of employees
SELECT
  first_name,
  last_name,
  NOW() - hire_date AS service_length
FROM
  employee;

-- Calculate ages in years, months, and days
SELECT
  employee_id,
  first_name,
  last_name,
  AGE(birthday)
FROM
  employee;












