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

SELECT '{"name": "Teriz", "age": 22}'::jsonb ;

SELECT to_jsonb('{"name": "Teriz", "age": 22}'::jsonb) ;
SELECT to_jsonb('Hello World') ;
	
	


