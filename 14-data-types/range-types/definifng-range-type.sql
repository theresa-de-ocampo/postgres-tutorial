/**
 * Users can define their own range types.
 * The most common reason to do this is to use ranges over subtypes not provided among the built-in range types.
 * 
 * When you defined your own range you automatically get a crresponding multirange type.
 */
CREATE TYPE float8range AS RANGE (
  subtype = float8,
  subtype_diff = float8mi
);

SELECT float8range(1.234, 5.678);
SELECT '[1.234, 5.678]'::float8range;

/**
 * If the subtype is considered to have discrete rather than continuous values, the CREATE TYPE
 * should specify a canonical function.
 * 
 * The canonicalization function takes an input range value,
 * and must return an equivalent range value that may have different bounds and formatting.
 * The canonical output for two ranges that represent the same set of values,
 * for example the integer ranges [1, 7] and [1, 8), must be identical.
 * 
 * In addition to adjusting the inclusive/exclusive bounds format, a canonicalization function
 * might round off boundary values, in case the desired step is larger than what the subtype
 * is capable of storing.
 * 
 * For instance, a range type over timestamp could be defined to have a step size of an hour,
 * in which case the canonicalization function would need to round off bounds that weren't a multiple of hour,
 * or perhaps throw an error instead.
 */

-- TODO: Study the indexing part



