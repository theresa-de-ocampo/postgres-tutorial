/* This command displays the execution plan that the PostgreSQL planner generates for the supplied
 * statement. The execution shows how the table(s) referenced by the statement will be scanned - 
 * by plain sequential scan, index scan, etc - and if multiple tables are referenced, what join
 * algorithms will be used to bring together the required rows from each input table.
 * 
 * The most important and useful information that EXPLAIN statement returns are start-cost before
 * the first row can be returned and the total cost to return the complete result set.
 * 
 * EXPLAIN [ (option [,...]) ] sql_statement;
 * 
 * where option can be one of the following:
 * 
 * ANALYZE [ boolean ]
 * VERBOSE [ boolean ]
 * COSTS   [ boolean ]
 * BUFFERS [ boolean ]
 * TIMING  [ boolean ]
 * SUMMARY [ boolean ]
 * FORMAT  { TEXT | XML | JSON | YAML }
 * */


/* ANALYZE
 * Keep in mind that the statement is actually executed when the ANALYZE option is used.
 * If you wish to use EXPLAIN ANALYZE without letting the command affect your data, use:
 * 
 * BEGIN;
 * EXPLAIN ANALYZE ...;
 * ROLLBACK;
 * */

/* VERBOSE
 * Shows you additional information regarding the plan. This is set to FALSE by default.
 * */

/* COSTS
 * The COSTS option includes the estimated startup and total costs of each plan node, as well as
 * the estimated number of rows and the estimated width of each row in the query plan.
 * Defaults to TRUE.
 * */

/* BUFFERS
 * Adds information to the buffer usage, and can only be used when ANALYZE is enabled.
 * FALSE by default.
 * */

/* TIMING
 * Includes the actual start-up time and time spent in each node.
 * DEFAULTS to TRUE, and can only be used when ANALYZE is enabled.
 * 
 * Actual start-up time is kinda hard to distinguish on default format, use JSON instead.
 * */

/* SUMMARY
 * Adds information such as total timing after the query plan.
 * When ANALYZE option is used, the summary information is included by default.
 * */

/* FORMAT
 * This parameter is set to TEXT by default.
 * */

EXPLAIN (FORMAT JSON)
SELECT * FROM film;

SELECT COUNT(*) FROM film;



