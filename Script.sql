CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE customer (
	id UUID PRIMARY KEY,
	fname TEXT NOT NULL,
	lname TEXT NOT NULL,
	address JSONB NOT NULL
);

INSERT INTO customer
VALUES 
	(uuid_generate_v4(), 'Teriz', 'De Ocampo', '{"street": "Callejon II", "city": "Naic"}'),
	(uuid_generate_v4(), 'Fe', 'Nable', '{"street": "Main Steet", "city": "Veere"}') ;

SELECT * FROM customer WHERE id = 'a709ecd3-ba00-4068-b3ed-3ce5bd63eff4' ;

UPDATE customer SET address = jsonb_set(address, '{city}', '"Naic"') WHERE id = 'a709ecd3-ba00-4068-b3ed-3ce5bd63eff4' ;

