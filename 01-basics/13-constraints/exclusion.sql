-- https://www.cybertec-postgresql.com/en/postgresql-exclusion-constraints-beyond-unique/
-- "exclusion constrains" are "beyond unique"

/* A simple exclusion constraint
 * Typically, people want to avoid bookings that overlap each other.
 * Somebody might want to make sure that the same car is not leased out to more than one customer
 * at the same time, or you might just want to make sure that a driver is not scheduled to drive
 * two cars at the same time.
 * 
 * Postgres offers a nice way to achieve this.
 * When creating a table, you can add EXCLUDE USING gist along with a restriction.
 * */

CREATE EXTENSION IF NOT EXISTS btree_gist;

CREATE TABLE car_reservation(
  car_reservation_id UUID DEFAULT gen_random_uuid() NOT NULL,
  car_id SMALLINT NOT NULL,
  schedule TSRANGE NOT NULL,
  EXCLUDE USING gist (car_id WITH =, schedule WITH &&)
);

/* Postgres will build an index covering both columns,
 * and it will ensure that the time range column is not allowed to contain overlapping data,
 * i.e., for the same car.
 * 
 * When you check its DDL, behind the scenes, EXCLUDE created a constraint and an index.
 * 
 * Note that you need to have the btree_gist extension installed. Or you'll get:
 * ERROR: data type smallint has no default operator class for access method "gist"
 */

INSERT INTO
  car_reservation (car_id, schedule)
VALUES
  (1, '[2025-09-22 09:00:00, 2025-09-22 10:00:30)');

SELECT
  *
FROM
  car_reservation;

/* A more practical exclusion constraint example
 * However, in real life, things might be a bit more complicated.
 * If customer returns a car, it might actually need some cleaning.
 * The company might decide not to instantly rent it out again until it is properly prepared for
 * the next client.
 * 
 * The question now is, how can we tell Postgres about this business requirement?
 */

CREATE OR REPLACE FUNCTION add_buffer(
  TSRANGE,
  INTERVAL
)
  RETURNS TSRANGE
  LANGUAGE SQL IMMUTABLE
AS $$
  SELECT tsrange(lower($1), upper($1) + $2);
$$;

/* If you want to add buffer before and after, use:
 * SELECT tsrange(lower($1) - $2, upper($1) + $2);
 * 
 * The important thing is that the function is IMMUTABLE.
 * We need a perfectly deterministic return value here,
 * because otherwise, the process does not work at all.
 * 
 * For the same inputs, it always gives the same output.
 * That's true here, because it's pure math with no database lookups or volatility.
 */

SELECT * FROM add_buffer('[2025-09-25 09:00:00, 2025-09-25 10:00:00)', INTERVAL '30 minutes');

SELECT * FROM add_buffer('[2025-09-25 09:00:00, 2025-09-25 12:00:00)', INTERVAL '1 hour');

CREATE TABLE car_reservation_v2(
  car_reservation_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  car_id SMALLINT NOT NULL,
  schedule TSRANGE NOT NULL,
  EXCLUDE USING gist (car_id WITH =, add_buffer(schedule, INTERVAL '1 hour') WITH &&)
);

INSERT INTO
  car_reservation_v2 (car_id, schedule)
VALUES
  (1, '[2025-09-22 09:00:00, 2025-09-22 10:00:30)');

SELECT
  *
FROM
  car_reservation_v2;

INSERT INTO
  car_reservation_v2 (car_id, schedule)
VALUES
  (1, '[2025-09-22 10:30:00, 2025-09-22 11:30:00)');




