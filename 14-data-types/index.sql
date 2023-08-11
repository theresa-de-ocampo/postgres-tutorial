DROP TABLE IF EXISTS employee ;

CREATE TABLE employee (
	employee_id INT NOT NULL,
	body jsonb
);

INSERT INTO employee VALUES
(1, '{"name": "Teriz", "hobbies": ["Netflix", "Jogging", "Coding"]}');

INSERT INTO employee VALUES
(2, '{"name": "Deo", "hobbies": ["Gaming", "Movies", "Hiking"]}');

SELECT * FROM employee;

UPDATE employee SET body = '{"name": "Teriz", "hobbies": ["Movies", "Jogging", "Coding"]}'
WHERE body->>'name' = 'Teriz';

SELECT DISTINCT 
	jsonb_array_elements_text(body->'hobbies') AS hobbies
FROM employee; 

SELECT
	employee_id,
	body
FROM
	employee
WHERE
	body->'hobbies' @> '["Gaming"]';

SELECT employee_id, body FROM employee WHERE body->'hobbies' @> '["Movies"]';

SELECT body->'hobbies' FROM employee;

SELECT
	employee_id,
	body
FROM
	employee
WHERE
	body->>'name' LIKE 'T%' ;

SELECT '{"name": "Teriz", "age": 22}'::jsonb ;

SELECT to_jsonb('{"name": "Teriz", "age": 22}'::jsonb) ;
SELECT to_jsonb('Hello World') ;
	
	


