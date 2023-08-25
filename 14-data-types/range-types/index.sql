-- https://www.postgresql.org/docs/current/rangetypes.html

-- Range types are data types representing a range of values of some element type (called the range's subtype).
-- For example, the range of int4 is called int4range.

/**
 * Use int4range to represent 1, 2, 3, 4, and 5
 * 
 * Sparse range types use [) to represent a range of elements.
 * In this, the bracket indicates inclusion and a parenthesis indicates exclusion.
 * Sparse range types must have canonical functions defined, which converts the storage format to [)
 * And for a sparse range type, we know what the previous value and the following value of a specific value.
 * For example, the value 1 in an int range is preceded by 0 and followed by 2.
 */
SELECT '(0,6)'::int4range;  -- [1,6)
SELECT '[1,6)'::int4range;  -- [1,6)
SELECT '(0,5]'::int4range;  -- [1,6)
SELECT '[1,5]'::int4range;  -- [1,6)
SELECT int4range('(0,6)');  -- [1,6)


/**
 * If this is a numeric range, we do not know the value before 1 (0.9999999999... till infinite)
 * and the value after 1 (1.00000000... 1).
 * However, continuous range types store accurate elements.
 */
SELECT '(0,6)'::numrange;   -- (0,6)
SELECT '[1,6)'::numrange;   -- [1,6)
SELECT '(0,5]'::numrange;   -- (0,6]
SELECT '[1,5]'::numrange;   -- [0,5]


-- *** Some Features in Postgres

/**
 * Postgres comes with the following built-in range types.
 * int4range - Range of INTEGER
 * int8range - Range of BIGINT
 * numrange  - Range of NUMBER
 * tsrange   - Range of TIMESTAMP WITHOUT TIME ZONE
 * tstzrange - Range of TIMESTAMP WITH TIME ZONE
 * daterange - Range of DATE
 */

-- *** Examples of Built-in Range Types
CREATE TABLE reservation(
  room int,
  duration tsrange
);

INSERT INTO reservation
VALUES
  (1108, '[2010-01-01 14:30, 2010-01-01 15:30)');

-- Containment
SELECT int4range(10,20) @> 3;

-- Overlaps
SELECT numrange(11.1, 22.2) && numrange(20, 30);

-- Extract upper bound
SELECT upper(int8range(15,25));

-- Compute the intersection
SELECT int4range(10, 20) * int4range(15, 25);

-- Is the range empty?
SELECT isempty(numrange(1, 5));
SELECT isempty('empty'::int4range);

SELECT lower_inc('[1, 4]'::int4range);
SELECT upper_inc('[1, 4]'::int4range);

-- *** Infinite (Unbounded) Ranges
SELECT '(,3]'::int4range;
SELECT '[,]'::int4range;
SELECT lower_inf('[1, 4]'::int4range);
SELECT lower_inf('(,3]'::int4range);

-- Includes no points (and will be normalized to 'empty')
SELECT '[4,4)'::int4range;





