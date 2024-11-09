SELECT
  *
FROM
  pg_timezone_names;

/**
 * https://www.enterprisedb.com/postgres-tutorials/postgres-time-zone-explained
 * 
 * AT TIME ZONE has two capabilities. It allows time zones to be added to date/time values that lack
 * them (TIMESTAMP WITHOUT TIME ZONE, ::timestamp), and allows TIMESTAMP WITH TIME ZONE values
 * (::timestamptz) to be shifted to non-local time zones and the time zone designation removed.
 * 
 * In summary, it allows:
 * (1) TIMESTAMP WITHOUT TIME ZONE -> TIMESTAMP WITH TIME ZONE
 * (2) TIMESTAMP WITH TIME ZONE -> TIMESTAMP WITHOUT TIME ZONE
 */

-- Adding Time Zone Designations
SELECT '2018-09-02 07:09:19'::TIMESTAMP AT TIME ZONE 'America/Chicago';

-- Removing Time Zone Designations
SELECT '2018-09-02 07:09:19'::TIMESTAMPTZ AT TIME ZONE 'Asia/Tokyo';


-- However, when used without date, it always result in TIMETZ.
SELECT TIME '08:00' AT TIME ZONE 'Asia/Manila'; -- Converted TO TIMETZ
SELECT TIMETZ '08:00' AT TIME ZONE 'Asia/Manila'; -- Still TIMETZ
SELECT
  CURRENT_TIME AT TIME ZONE 'Europe/Berlin', -- Still TIMETZ
  CURRENT_TIME AT TIME ZONE 'America/Costa_Rica'; -- Still TIMETZ

  






