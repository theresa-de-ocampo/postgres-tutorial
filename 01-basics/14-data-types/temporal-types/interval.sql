/*
 * The interval values are useful when doing date or time arithmetic.
 * For e.g., if you want to know the time of 3 hours 20 minutes ago at the current time of last year:
 * */
SELECT
  now(),
  now() - INTERVAL '1 year 3 hours 20 minutes' AS "3 hours 20 minutes ago of last year";
  
-- Postgres Interval Output Formats
-- Postgres provides four output formats: sql_standard, postgres, postgres_verbose, iso_8601

 -- +6-5 +4 +3:02:01
SET intervalstyle = 'sql_standard';
SELECT
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';
  
-- Default: 6 years 5 mons 4 days 03:02:01
SET intervalstyle = 'postgres';
SELECT
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

-- @ 6 years 5 mons 4 days 3 hours 2 mins 1 sec
SET intervalstyle = 'postgres_verbose';
SELECT
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';

-- P6Y5M4DT3H2M1S
SET intervalstyle = 'iso_8601';
SELECT
  INTERVAL '6 years 5 months 4 days 3 hours 2 minutes 1 second';
  
-- You can apply arithmetic operators to the interval values.
SELECT
  INTERVAL '2h 50m' - INTERVAL '10m' ;

/*
 * INTERVAL '1 day' is an interval literal.
 * This means, as written, and without any casting, it states a literal Postgres INTERVAL value.
 * 
 * On the other hand, '1 day'::INTERVAL is actually a cast of the text 1 day to make it an INTERVAL value.
 * See also TIMESTAMP.
 * 
 * The :: casting syntax is not part of the ANSI standard, and is specific to Postgres.
 * If you were concerned about having to one day possibly port your Postgres code to another database,
 * then you might stick with using CAST() over ::, the former of which is supported on most other DBs.
 * */
SELECT
  INTERVAL '2h 50m' + INTERVAL '10m' ;

SELECT
  INTERVAL '2h 50m' + '10m'::INTERVAL ;
  
SELECT
  600 * INTERVAL '1 minute' ;
  
SELECT
  to_char(INTERVAL '17h 20m 05s', 'HH24:MI:SS');
  
SELECT date_part('minute', INTERVAL '5h 30m');

/*
 * Adjusting Interval Values
 * justify_days(interval) - used to adjust interval so 30-day time period are represented as months.
 * justify_hours(interval) - used to adjust interval so 24-hour time periods are represented as days.
 * */
SELECT justify_days(INTERVAL '365 days');
SELECT justify_hours(INTERVAL '32 hours');
SELECT justify_interval(INTERVAL '1 year - 1 hour');