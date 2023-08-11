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

SELECT CURRENT_TIME;
SELECT CURRENT_TIME(1); -- ??
SELECT LOCALTIME;

-- Convert time with a different time zone:
-- [TIME with time zone] AT TIME ZONE time_zone
SELECT localtime AT TIME ZONE 'UTC-7';

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


