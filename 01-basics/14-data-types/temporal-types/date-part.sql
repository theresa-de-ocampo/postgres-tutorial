-- date_part function allows you to retrieve sub-fields from a temporal value.
-- date_part(field, source)

/*
 * The field is an identifier that determines what field to extract from the source.
 * The values of the field must be in a list of permitted values:
 * 
 * century
 * decade
 * year
 * month
 * day
 * hour
 * minute
 * second
 * microseconds
 * milliseconds
 * dow
 * doy
 * epoch
 * isodow
 * isoyear
 * timezone
 * timezone_hour
 * timezone_minute
 * 
 * */

-- The source is a temporal expression that evaluates to TIMESTAMP, TIME, OR INTERVAL.
-- If the source evaluates to DATE, the function will cast to TIMESTAMP.

SELECT date_part('century', TIMESTAMP '2017-01-01');
SELECT date_part('quarter', CURRENT_DATE);
SELECT date_part('week', CURRENT_DATE);

SELECT date_part('week', DATE '2023-01-01');

/*The behavior you're seeing is because the date_part() function returns the week number according to the ISO-8601 standard, which defines the first week of the year as the one that contains January 4 of that year.

In the case of SELECT date_part('week', DATE '2023-01-01');, January 1st, 2023 falls on a Sunday. Therefore, it is considered to be part of the last week of the previous year (2022) and week 1 of 2023 starts on Monday, January 2nd.
*/

SELECT date_part('week', DATE '2023-01-02');
SELECT EXTRACT(WEEK FROM DATE '2023-01-02');

-- The date_part function returns a value whose type is float.
SELECT date_part('year', CURRENT_DATE);

SELECT
  date_part('hour', TIMESTAMP '2017-03-18 10:20:30') AS h,
  date_part('minute', TIMESTAMP '2017-03-18 10:20:30') AS m,
  date_part('second', TIMESTAMP '2017-03-18 10:20:30') AS s;

-- To extract day of week, or day of year from a timestamp:
-- dow: 0=Sunday, 1=Monday, 2=Tuesday, ... 6=Saturday
SELECT
  date_part('dow', CURRENT_DATE) AS dow,
  date_part('doy', CURRENT_DATE) AS doy;




