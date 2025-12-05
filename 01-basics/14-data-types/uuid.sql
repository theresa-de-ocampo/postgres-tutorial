-- Universal Unique Identifier - Open Source Software Project
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Generates UUID based on the combination of computer's MAC address,
-- current timestamp, and a random value.
SELECT uuid_generate_v1();

-- If you want to generate a UUID solely based on random numbers:
SELECT uuid_generate_v4();

-- If you only need randomly-generated v4 UUIDs, use gen_random_uuid() instead.
-- This is natively supported in Postgres without requiring an extension.
-- This also supports DBeaver's foreign key navigation.
SELECT gen_random_uuid();