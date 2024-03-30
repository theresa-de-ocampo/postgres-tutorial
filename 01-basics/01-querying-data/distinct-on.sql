-- https://stackoverflow.com/questions/46566602/what-does-distinct-on-expression-do

-- https://python.plainenglish.io/the-difference-between-distinct-vs-distinct-on-in-postgresql-87ca6ee70450

-- DISTINCT ON keeps only the first row of each set.

CREATE TABLE address_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  person_id INT,
  address_id INT,
  effective_date DATE
);

INSERT INTO
  address_history (person_id, address_id, effective_date)
VALUES
  (2, 1, '2000-01-01'), -- Moved to first house
  (2, 2, '2004-08-19'), -- Moved to university
  (2, 1, '2007-06-12'), -- Moved back home
  (4, 3, '2007-05-18'), -- Moved to first house
  (4, 4, '2016-02-09'); -- Moved to new house
  
SELECT DISTINCT ON (person_id)
  *
FROM
  address_history
ORDER BY
  person_id,
  effective_date DESC;
  
SELECT DISTINCT
  person_id,
  address_id,
  effective_date
FROM
  address_history
ORDER BY
  person_id,
  effective_date DESC;
  

SELECT
  *
FROM
  (
    SELECT
      *,
      ROW_NUMBER() OVER (
        PARTITION BY person_id
        ORDER BY effective_date DESC
      ) AS address_row
    FROM
      address_history
  ) AS address_history_with_row_number
WHERE
  address_row = 1;
  
