CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Generates UUID based on the combination of computer's MAC address,
-- current timestamp, and a random value.
SELECT uuid_generate_v1();

-- If you want to generate a UUID solely based on random numbers:
SELECT uuid_generate_v4();