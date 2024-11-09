/**
 * Guidelines:
 *  - A subquery must be enclosed in parenthesis.
 *  - Use single-row operators with single-row subqueries,
 *    and use multiple-row operators with multiple-row subqueries.
 *  - If a subquery (inner query) returns a null value to the outer query,
 *    the outer query will not return any rows when using certain comparison operators in a WHERE clause.
 */

/**
 * Types of subqueries.
 *  (1) Subquery as Scalar Operand
 *  (2) Comparison using Subqueries
 *  (3) Subqueries with ALL, ANY/SOME, IN
 *  (4) Correlated Subqueries
 *  (5) Subqueries in the FROM clause 
 */

-- 1. SUBQUERY AS A SCALAR OPERAND
-- A scalar subquery returns a single value that may be used as operand to scalar functions like UPPER.
SELECT
  employee_id,
  last_name,
  CASE
    WHEN department_id = (SELECT department_id FROM departments WHERE location_id = 2500) THEN 'Canada'
    ELSE 'USA'
  END
FROM
  employees;

SELECT
  employee_id,
  first_name,
  last_name,
  (
    SELECT department_name
    FROM departments
    WHERE employees.department_id = departments.department_id
  ) AS department
FROM
  employees;


-- 2. COMPARISON USING SUBQUERIES
SELECT
  employee_id,
  first_name,
  last_name,
  salary
FROM
  employees
WHERE
  salary < (SELECT AVG(salary) FROM employees);

-- 3.1. SUBQUERIES WITH ALL
-- Get the department with the highest average salary.
EXPLAIN ANALYZE
SELECT
  department_id,
  AVG(salary) AS avg_salary
FROM
  employees
GROUP BY
  department_id
HAVING
  AVG(salary) >= ALL (
    SELECT AVG(salary) FROM employees GROUP BY department_id
  );

EXPLAIN ANALYZE
SELECT
  department_id,
  AVG(salary) AS avg_salary
FROM
  employees
GROUP BY
  department_id
ORDER BY
  avg_salary DESC
LIMIT 1;

-- 3.2. SUBQUERIES WITH ANY
-- Get all employees with department location of 1700
EXPLAIN
  (ANALYZE, FORMAT JSON)
SELECT
  first_name,
  last_name,
  department_id
FROM
  employees
WHERE
  employees.department_id = ANY (
    SELECT department_id
    FROM departments
    WHERE location_id = 1700
  );

EXPLAIN
  (ANALYZE, FORMAT JSON)
SELECT
  first_name,
  last_name,
  department_id
FROM
  employees
INNER JOIN
  departments USING (department_id)
WHERE
  location_id = 1700;

-- 4. CORRELATED SUBQUERIES
-- Get all employees who earn more than the average salary in their department
SELECT
  employee_id,
  first_name,
  last_name,
  salary,
  department_id
FROM
  employees outer_employees
WHERE
  salary >= (
    SELECT AVG(salary)
    FROM employees WHERE employees.department_id = outer_employees.department_id
  );








