# `RETURN` Statements

## Function 1

```sql
CREATE OR REPLACE FUNCTION public.find_last_transaction_id(customer_id text)
  RETURNS TEXT
  LANGUAGE 'sql'
AS $BODY$
  SELECT
    body->'external_service'->>'payment_id' AS transaction_id
  FROM
    orisonx_payment
  WHERE
    body->'metadata'->>'customer' = customer_id
    AND body->>'type' IN ('first','recurring')
    AND body->'external_service'->>'payment_id' IS NOT NULL
  ORDER BY
    created_at DESC
  LIMIT
    1;
$BODY$;
```

## Function 2

```sql
CREATE OR REPLACE FUNCTION public.teriz_find_last_transaction_id(customer_id TEXT)
  RETURNS TEXT
  LANGUAGE plpgsql
AS $$
  DECLARE transaction_id TEXT;

  BEGIN
    SELECT
      body->'external_service'->>'payment_id'
    INTO
      transaction_id
    FROM
      orisonx_payment
    WHERE
      body->'metadata'->>'customer' = customer_id
      AND body->>'type' IN ('first','recurring')
      AND body->'external_service'->>'payment_id' IS NOT NULL
    ORDER BY
      created_at DESC
    LIMIT
      1;

    RETURN transaction_id;
  END;
$$;
```

## Differences

The first function uses the SQL language (`LANGUAGE sql`). In SQL functions, the last query in the function's body is automatically treated as the return value of the function. This is because SQL functions are essentially wrappers around a single SQL query. If the query returns a single value (e.g., a single column or row), then that value is used as the function's return value.

In PL/pgSQL functions, an explicit `RETURN` statement is required to return a value, because `plpgsql` functions can include multiple queries, and variables.

## SQL functions are a better choice

- For **simple scalar queries**. Not much to plan, better save any overhead.
- For single (or very few) calls per session. Nothing to gain from plan caching via prepared statements that PL/pgSQL has to offer.
- If they are typically called in the context of bigger queries and are simple enough to be **inlined**.

## PL/pgSQL are a better choice

- When you need any **procedural elements** or **variables** that are not available in SQL functions.
- For any kind of **dynamic SQL**, where you build and `EXECUTE` statements dynamically.
- When you have **computations** that can be **reused** in several places. You don't have variables in SQL functions.
- When a function cannot be inlined and is called repeatedly. Unlike with SQL functions, query plans can be cached for all SQL statements inside a PL/pgSQL functions. They are treated like prepared statements, the plan is cached for repeated calls within the same session if Postgres expects the cached plan to perform better than re-planning every time. That's the reason why PL/pgSQL are typically faster after the first couple of calls.

## Reference

- https://stackoverflow.com/questions/24755468/language-sql-vs-language-plpgsql-in-postgresql-functions
