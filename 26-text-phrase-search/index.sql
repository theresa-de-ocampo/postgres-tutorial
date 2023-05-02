SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('fox') AS FOUND;

SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('foxes') AS FOUND;

SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('foxtrot') AS FOUND;

SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('quick brown') AS FOUND;
    
    