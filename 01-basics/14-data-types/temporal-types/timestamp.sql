-- The timestamp datatype allows you to store both the date and time.
-- But it does not have any time zone data.

-- It means that when you change the timezone of your database server,
-- the timestamp value stored in the database will not change automatically.

-- When you insert a value into a timestamptz column, Postgres converts the timestamptz
-- value into a UTC value, and stores the UTC value in the table.

-- It's important to note that timestamptz value is stored as a UTC value.
-- Postgres does not store any timezone data with the timestamptz value.

CREATE TABLE timestamp_demo(
  ts TIMESTAMP,
  tstz TIMESTAMPTZ
);

SHOW TIMEZONE; -- Asia/Manila

SET TIMEZONE = 'America/Los_Angeles';

SHOW TIMEZONE;

INSERT INTO timestamp_demo
VALUES ('2023-05-01 19:10:25-07', '2023-05-01 19:10:25-07');

SELECT * FROM timestamp_demo;

-- ALTER DATABASE db_name
SET TIMEZONE = 'Asia/Manila';

-- Postgres extension
SELECT now();

-- SQL Standard
SELECT current_timestamp;

-- To get the current time without date
SELECT current_time;

SELECT timezone('America/Los_Angeles', now());

-- To get the time of the day in string format
SELECT timeofday();

-- Convert between timezones
SELECT timezone('Europe/Berlin', '2023-05-01 18:21:00');

-- When we pass timestamp to timezone as a string, Postgres casts it to timestamptz implicitly.
-- But is it better to cast it explicitly.
SELECT timezone('Europe/Berlin', '2023-05-01 18:21:00'::TIMESTAMPTZ);
SELECT timezone('Europe/Berlin', TIMESTAMPTZ '2023-05-01 18:21:00');

/**
 * AT TIME ZONE is the SQL standard.
 * timezone() is specific to Postgres.
 * In MySQL, it's convert_tz() 
 */




