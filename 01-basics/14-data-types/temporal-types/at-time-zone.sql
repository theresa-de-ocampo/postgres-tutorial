/**
 * AT TIME ZONE is an operator that allows you to convert a timestamp or timestamp with time zone to
 * a different time zone.
 * 
 * This operator can be useful when you want to perform timezone conversions within your queries.
 * 
 * timestamp_expression AT TIME ZONE target_timezone
 * 
 * Postgres uses the Internet Assigned Numbers Authority (IANA) Time Zone Database:
 * https://en.wikipedia.org/wiki/List_of_tz_database_time_zones 
 */

SET TIMEZONE TO 'America/Los_Angeles';
SHOW TIMEZONE;

-- 1. BASIC EXAMPLE
SELECT TIMESTAMP '2024-03-21 10:00:00' AT TIME ZONE 'Asia/Manila';

-- 2. CONVERTING TIMESTAMP WITH TIME ZONE
SELECT TIMESTAMP WITH TIME ZONE '2024-03-21 10:00:00-04' AT TIME ZONE 'UTC';

-- 3. CONVERTING ABBREVIATED TIMESTAMP WITH TIME ZONE
-- TIMESTAMPTZ is accepted as an abbreviation for TIMESTAMP WITH TIME ZONE
SELECT TIMESTAMPTZ '2024-03-21 10:00:00-04' AT TIME ZONE 'UTC';


-- 4. CONVERTING TIMESTAMP USING A TIME ZONE OFFSET
SELECT TIMESTAMP '2024-03-21 10:00:00' AT TIME ZONE '-08:00';