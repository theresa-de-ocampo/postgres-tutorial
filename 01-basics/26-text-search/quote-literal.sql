/**
  * The Postgres quote_literal function uses single quotes to quote a given string for using
  * as a string literal in SQL statement strings.
  * 
  * If a string contains single quotes, it will be converted to two single quotes.
  * For example, a'b -> 'a''b'
  * 
  * If the input is null, the function returns null.
  */

SELECT quote_literal(E'a\'b');
SELECT quote_literal(NULL);
SELECT NULL;

SELECT quote_nullable(E'a\'b');
SELECT quote_nullable(NULL);

SELECT quote_literal('How are you?');
SELECT quote_literal(123.45);