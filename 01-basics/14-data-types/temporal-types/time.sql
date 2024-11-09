CREATE TABLE work_shift(
  id SERIAL PRIMARY KEY,
  shift_name VARCHAR(50) NOT NULL,
  start_at TIME NOT NULL,
  end_at TIME NOT NULL
);

INSERT INTO
  work_shift (shift_name, start_at, end_at)
VALUES
  ('Morning', '08:00:00', '12:00:00'),
  ('Afternoon', '13:00:00', '17:00:00'),
  ('Night', '18:00:00', '22:00:00');

-- Besides the TIME data type, Postgres provides TIME with time zone data type.

SELECT * FROM work_shift;

-- To get the current time with time zone, you use the CURRENT_TIME function
SELECT CURRENT_TIME;

/**
 * Formatting. By default, the fractional seconds have a precision of six digits.
 * You can specify the desired precision between one and six using an argument.
 * DBeaver auto-formats, use psql to see it.
 */
SELECT CURRENT_TIME(2);


SELECT LOCALTIME;
SELECT LOCALTIME(2);

/**
 * CURRENT_TIME uses the local time zone of the server, while LOCALTIME is affected by the session's
 * time zone setting. If your session and server time zones are the same, they will return identical
 * values.
 */
SET TIMEZONE = 'Asia/Manila';
SELECT LOCALTIME, CURRENT_TIME;
SET TIMEZONE = 'Universal';

-- Convert time with a different time zone:
-- [TIME with time zone] AT TIME ZONE time_zone
SELECT localtime AT TIME ZONE 'UTC-7';
SELECT localtime AT TIME ZONE 'Asia/Manila';

SHOW TIMEZONE;

-- For some reason, it looks buggy with DBeaver.
-- Use pgAdmin or psql.
SELECT
  CURRENT_TIME AT TIME ZONE 'UTC-7' AS "UTC",
  CURRENT_TIME AT TIME ZONE 'Asia/Manila' AS "Asia/Manila";

-- Postgres allows you to apply arithmetic operators such as +, -, and * on
-- time values, and between time and interval values
SELECT time '10:00' - '02:00' AS "result" ;

/*
 * Double quotes are used to indicate identifiers within the database,
 * which are objects like tables, columns, and roles.
 * 
 * In contrast, single quotes are used to indicate string literals.
 * 
 * Hence, double quotes are used for escaping DB objects like table name/column, etc.
 * */
SELECT LOCALTIME + INTERVAL '2 hours' AS "result";


