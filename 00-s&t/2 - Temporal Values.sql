SELECT date_part('week', DATE '2023-09-08');
SELECT TIME '10:00' - '02:00';
SELECT date_part('hour', TIMESTAMP '2023-09-08 10:20:30');
SELECT date_part('minute', INTERVAL '5h 30m');

SELECT date_part('week', '2023-09-08'::DATE);
SELECT '10:00'::TIME - '02:00'::TIME;
SELECT date_part('hour','2023-09-08 10:20:30'::TIMESTAMP);
SELECT date_part('minute', '5h 30m'::INTERVAL);