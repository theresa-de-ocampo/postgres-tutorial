-- ***** FULL TEXT SEARCH VS. PHRASE SEARCH
/**
 * Full Text Search
 *    Operator: @@ (Matches)
 * 
 *    Purpose:
 *        Full text search is used to find documents or rows that contain specific words or terms.
 *        It's designed to handle natural language queries, and provides more flexibility in
 *        searching for text patterns.
 * 
 *    Example:
 *        SELECT *
 *        FROM articles
 *        WHERE to_tsvector('english', content) @@ to_tsquery('english', 'quick brown fox');
 * 
 *    Result:
 *        This query will return rows where the 'content' column contains the phrase
 *        "quick brown fox" but not necessarily in that order.
 */


/**
 * Phrase Search
 *    Operator: <-> (Phrase Distance)
 * 
 *    Purpose:
 *        Phrase search, also known as proximity search, is used to find documents where specific
 *        words or terms appear in close proximity to each other, typically in the exact order
 *        specified. It's stricter than a general full text search.
 * 
 *    Example:
 *        SELECT *
 *        FROM articles
 *        WHERE tsvector('english', content) @@ tsquery('english', 'quick <-> brown <-> fox');
 * 
 *    Result:
 *        This query will return rows where the 'content' column contains the phrase
 *        "quick brown fox" in that exact order.
 * 
 */
