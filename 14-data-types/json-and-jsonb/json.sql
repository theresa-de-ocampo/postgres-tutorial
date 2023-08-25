CREATE TABLE "order" (
  id SERIAL NOT NULL PRIMARY KEY,
  info JSON NOT NULL
);

INSERT INTO "order" (info)
VALUES
  ('{"customer": "Teriz De Ocampo", "items": {"product": "Doritos", "qty": 2 }}'),
  ('{"customer": "Josh William", "items": {"product": "Toy Car", "qty": 1}}'),
  ('{"customer": "Mary Clark", "items": {"product": "Toy Train", "qty": 2}}');
 
INSERT INTO "order" (info)
VALUES ('{"customer": "Thita De Ocampo", "items": {"product": {"name": "Diswashing Liquid", "qty": 2}}}');

SELECT info FROM "order";

/* The -> operator returns JSON object field by key. */
SELECT info->'customer' AS customer FROM "order";

/* The ->> operator returns JSON object field by text. */
SELECT info->>'customer' AS customer FROM "order";

/* 
  Because the -> operator returns a JSON object, you can chain it with the operator ->> to retrieve a specific node.
  For example, the following statement returns all products sold:
 */

SELECT info->'items'->>'product' AS product
FROM "order"
ORDER BY product;

SELECT info->>'customer' AS customer
FROM "order"
WHERE info->'items'->>'product' = 'Doritos';

/*
  Who brought 2 products at a time.
  But this will result in an error:
    ERROR:  operator does not exist: text = integer
    LINE 5: WHERE info->'items'->>'qty' = 2;
    No operator matches the given name and argument types. You might need to add explicit type casts.
*/
SELECT
  info->>'customer' AS customer,
  info->'items'->>'product' AS product
FROM "order"
WHERE info->'items'->>'qty' = 2;

SELECT
  info->>'customer' AS customer,
  info->'items'->>'product' AS product
FROM "order"
WHERE CAST (info->'items'->>'qty' AS INTEGER) = 2;

/* Apply aggregate functions to JSON data */
SELECT
  MIN (CAST (info->'items'->>'qty' AS INTEGER)),
  MAX (CAST (info->'items'->>'qty' AS INTEGER)),
  SUM (CAST (info->'items'->>'qty' AS INTEGER)),
  AVG (CAST (info->'items'->>'qty' AS INTEGER))
FROM "order";

/* JSON functions */
/* json_each allows us to expand the outermost JSON object into a set of key-value pairs. */
SELECT json_each(info)
FROM "order";

/* If you want to get a set of key-value pairs as text. */
SELECT json_each_text(info)
FROM "order";

/* json_object_keys gets the set of keys in the outermost JSON object */
SELECT json_object_keys(info->'items')
FROM "order";

/* The json_typeof() function returns the type of the outermost JSON value as a string. It can be number, boolean, null, object, array, and string. */
SELECT json_typeof(info->'items')
FROM "order";

SELECT json_typeof(info->'items'->'qty')
FROM "order";
