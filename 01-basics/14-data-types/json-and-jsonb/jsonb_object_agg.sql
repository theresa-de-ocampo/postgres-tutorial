/* This is an aggregate function. Aggregate functions compute a single result from a SETOF inputs.
 * jsonb_object_agg function aggregates key-value pairs into a single JSONB object.
 * It's often used to combine rows of key-value pairs into a single JSONB object.
 * */

CREATE TABLE person_details (
  id INT,
  key TEXT,
  value TEXT
);

INSERT INTO
  person_details (id, key, value)
VALUES
  (1, 'name', 'Alice'),
  (1, 'age', '30'),
  (1, 'city', 'New York'),
  (2, 'name', 'Bob'),
  (2, 'age', '25'),
  (2, 'city', 'Los Angeles');

SELECT
  id,
  jsonb_object_agg("key", "value") AS details
FROM
  person_details
GROUP BY
  id
ORDER BY
  id;


