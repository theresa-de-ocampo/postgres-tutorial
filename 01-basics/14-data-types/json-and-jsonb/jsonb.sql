/*
 * The Postgres jsonb_array_elements functions returns a set
 * including all the top-level elements in the JSONB array.
 * */

SELECT jsonb_array_elements('[1, 2, [3, 4]]');

-- Since the jsonb_array_elements() function return value is of type SETOF,
-- you can use jsonb_array_elements as a temporary table.
SELECT * FROM jsonb_array_elements('[1, 2, [3, 4]]');