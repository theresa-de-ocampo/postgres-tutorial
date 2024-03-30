-- TODO:
/**
 * tsquery provides a few operators for your use like the AND operator, OR operator, and the NEGATION operator which will be used in a later section of this article. It also recently added a <-> operator that allows you to search for word distance or proximity.

 */


-- https://hevodata.com/blog/postgresql-full-text-search-setup/

-- ***** INTRODUCTION

/**
 * The problem with traditional LIKE clause is that it has a very high-performance penalty.
 * That means, it takes a long time to return results as the words inside the text are not indexed.
 */

/**
 * Full Text Search is a technique to identify documents in natural language that satisfy a query.
 * Full Text Search is distinguished from searches based on metadata represented in databases.
 */

/**
 * (1) During a Postgres Full Text Search, Postgres does not include
 *     "stop words" like "the", or "a" while finding a match.
 * (2) It implements "stemming" to find derivatives of a root word.
 *     For e.g., stemming will map "runs" and "running" to the root word "run". 
 * (3) Postgres will rank your searchesand will place the best matches at the top of the results.
 */
-- Vector Technique


-- ***** FULL TEXT SEARCH ENTITIES
/**
 * To understand FTS, you need to be familiar with the ff. terms first:
 * 
 * (1) Document
 *        A set of data on which your full-text search will take place is called document.
 *        You can create a document using either a single or multiple columns, or even using
 *        multiple tables.
 * 
 * (2) Lexemes
 *        The document during processing is parsed into multiple tokens, which consists of words,
 *        sentences, etc. of the text present in the document. These tokens are are modified to form 
 *        more meaningful entities called lexemes.
 * 
 * (3) Dictionaries
 *        The conversion of tokens to lexemes is done using dictionaries.
 *        Postgres offers both options of either using built-in dictionaries, or creating your own
 *        dictionaries. These dictionaries are responsible to determine whether which stop words are
 *        not important, and whether differently derived words have the same base language.
 */

/**
 * Definition
 * Lexemes, also called word stems, are minimal units of language (often words) with distinctive
 * meanings. The word cut is a lexeme that would be a dictionary entry, but its inflected versions,
 * e.g., cuts, cutting, etc., may be included depending on the dictionary.
 * These inflected versions may be included as variations in the entry for cut.
 * 
 * Deep Dive
 * Inflection is a change in the form of a word that expresses a shift in tense, mood, case, gender, 
 * person, or number.
 */

-- ***** CORE CONCEPTS OF FULL TEXT SEARCH
-- The tsvector type represents a document in a form optimized for text search;
-- the tsquery type similarly represents a text query.

/**
 * PostgreSQL offers several native functions that can help you in implementing FTS:
 * 
 * (1) to_tsvector
 *    This function is used to create a list of tokens of tsvector data type.
 *    ts stands for “Text Search”.
 * 
 * (2) to_tsquery
 *    This function can be used for querying the vector for occurrences of particular words.
 * 
 * (3) Searching via @@ and <->
 *    This process uses the to_tsvector and to_tsquery functions to provide fast results.
 */

-- This returns a VECTOR where every token is a lexeme (a unit of lexical meaning) with POINTERS.
-- By default, every word is normalized as a lexeme in English.
-- For instance, "jumped" becomes "jump"
SELECT
  to_tsvector('The quick brown fox jumped over the lazy dog.');
  
-- SQL Error [42601]: ERROR: syntax error in tsquery
-- The input text is not in the correct format for constructing a tsquery.
-- To create a tsquery from a plain text input, you typically use the plainto_tsquery function.
SELECT
  to_tsquery('The quick brown fox jumped over the lazy dog');

-- You can use the following Postgres functions to convert text fields to tsquery values:
-- to_tsquery, plainto_tsquery, and phraseto_tsquery.
SELECT plainto_tsquery('The quick brown fox jumped over the lazy dog');
 
SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('fox') AS FOUND;

SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('foxes') AS FOUND;

SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@ to_tsquery('foxtrot') AS FOUND;

SELECT
    to_tsvector('The quick brown fox jumped over the lazy dog.') @@
    plainto_tsquery('quick brown') AS FOUND;