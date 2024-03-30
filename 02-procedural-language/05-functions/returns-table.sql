CREATE OR REPLACE FUNCTION get_film (title_pattern VARCHAR)
    RETURNS TABLE (
        film_title VARCHAR,
        film_release_year YEAR
    )
    LANGUAGE plpgsql
AS $$
    BEGIN
        RETURN QUERY
        SELECT
            title,
            release_year
        FROM
            film
        WHERE title ILIKE title_pattern;
    END;
$$;
    
    
SELECT * FROM get_film ('Al%');

-- If you call the function using the following statement,
-- Postgres returns a table that consists of one column that holds an array of rows.
SELECT get_film('Al%');






    