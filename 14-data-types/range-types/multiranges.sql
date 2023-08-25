SELECT '{}'::int4multirange;
SELECT '{[3,7)}'::int4multirange;
SELECT '{[3,7), [8,9)}'::int4multirange;

-- **** Constructing Ranges, and Multiranges

/**
 * Each range type has a constructor function with the same name as the range type.
 * Using the constructor function is frequently more convenient than writing a range literal constant,
 * since it avoids the need for extra quoting of the bound values.
 * 
 * The constructor function accepts two or three arguments.
 * The two-argument form contructs a range in standard form (lower bound inclusive, upper bound exclusive).
 * While the three-argument form constructs a range with bounds of the form specifid by the third argument.
 */

SELECT numrange(1.0, 14);
SELECT numrange(1.0, 14, '(]');

-- Although '(]' is specified here, on display the value will be converted to canonical form,
-- since int8range is a discrete range type.
SELECT int8range(1, 14, '(]');

-- Using NULL for either bound, causes the range to be unbounded on that side.
SELECT numrange(NULL, 2.2);

-- Each range type also has a multirange constructor with the same name as the multirange type.
-- The constructor takes zero or more arguments which are all ranges of the appropriate type.
SELECT nummultirange();
SELECT isempty(nummultirange());
SELECT nummultirange(numrange(1.0, 14));
SELECT nummultirange(numrange(1.0, 14), numrange(24.0, 25.0));

-- **** Discrete Range Types
/**
 * A discrete range is one whose element type has a well-defined "step", such as integer, or date.
 * In these types, two elements can be said to be adjacent, when there are no valid values between them.
 * 
 * Integer range type [4,8] and (3,9) denote the same set of values;
 * but this would not be so for a range over numeric.
 * 
 * A discrete range type should have a canonicalization function that is aware of the desired
 * step size for the element type. 
 * 
 * The canonicalization function is charged with converting equivalent values of the range type
 * to have identical representations, in particular consistently inclusive or exclusive bounds. 
 * 
 * If a canonicalization function is not specified, then ranges with different formatting will
 * always be treated as unequal, even though they might represent the same set of values in reality.
 */


