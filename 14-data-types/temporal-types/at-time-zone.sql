-- https://www.postgresql.org/docs/current/datatype-datetime.html#:~:text=We%20do%20not%20recommend%20using,are%20stored%20internally%20in%20UTC%20.

-- To address these difficulties, we recommend using date/time types that contain both date and time when using time zones. We do not recommend using the type time with time zone (though it is supported by PostgreSQL for legacy applications and for compliance with the SQL standard). PostgreSQL assumes your local time zone for any type containing only date or time.
--
--All timezone-aware dates and times are stored internally in UTC. They are converted to local time in the zone specified by the TimeZone configuration parameter before being displayed to the client.

-- https://stackoverflow.com/questions/5876218/difference-between-timestamps-with-without-time-zone-in-postgresql

-- at time zone
-- timezon with timestamp
-- > < created_at

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE customer_14 (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

INSERT INTO customer_14 (name)
VALUES ('Teriz');

SET TIMEZONE = 'Europe/Amsterdam';
SET TIMEZONE = 'Asia/Manila';

SHOW TIMEZONE;

INSERT INTO customer_14 (name)
VALUES ('Luc');

SELECT * FROM customer_14;

INSERT INTO customer_14 (name, created_at)
VALUES
  ('Karl', '2023-08-30 08:00:00'),
  ('')
  
tERIZ - 11:51 am
luc - 11:53 am | 5:53am AT amsterdam


ASIA
f7f3dab8-1d6b-4de4-9869-5c2c1606650f  Teriz 2023-09-06 11:51:00.449 +0800
1aeba6d1-3d0a-47b6-af68-a14bc2e5c670  Luc 2023-09-06 11:53:35.112 +0800

EUROPE
f7f3dab8-1d6b-4de4-9869-5c2c1606650f  Teriz 2023-09-06 11:51:00.449 +0800
1aeba6d1-3d0a-47b6-af68-a14bc2e5c670  Luc 2023-09-06 11:53:35.112 +0800

-- Even if you set timezone, insert will pull the time from your computer
-- Same with select



SELECT '2018-09-02 07:09:19-10'::timestamp;
  
  
  
  
  
  
  
  
  
  
  
  