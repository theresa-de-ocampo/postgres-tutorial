/**
 * Use FOR LOOP statements to iterate over a range of integers or a result set of a query.
 * 
 * [<<label>>]
 * FOR loop_counter IN [ REVERSE ] from..to [by step] LOOP
 *    statements;
 * END LOOP [ label ];
 * 
 * The FOR LOOP creates an integer variable loop_counter which is accessible only inside the loop.
 * By default, the FOR loop increases the loop_counter by step after each iteration.
 * However, when you use the REVERSE option, the FOR LOOP decreases the loop_counter by the step.
 * 
 * The from and to are expressions that specify the lower and upper bound of the range.
 * 
 * The step that follows the BY keyword specifies the iteration step.
 * It is optional and defaults to 1. 
 */
DO $$
  BEGIN
    FOR counter IN 1..5 LOOP
      RAISE NOTICE '%', counter;
    END LOOP;
  END;
$$;

DO $$
  BEGIN
    FOR counter IN REVERSE 5..1 LOOP
      RAISE NOTICE '%', counter;
    END LOOP;
  END;
$$;

DO $$
  BEGIN
    FOR counter IN 1..6 BY 2 LOOP
      RAISE NOTICE '%', counter;
    END LOOP;
  END;
$$;


/**
 * Iterate over a result set.
 * [<<label>>]
 * FOR record IN query LOOP
 *    statements;
 * END LOOP [label];
 * 
 * Display the Top 10 Longest Films
 */
DO $$
  DECLARE v_film RECORD;

  BEGIN
    FOR v_film IN
      SELECT
        title,
        "length"
      FROM
        film
      ORDER BY
        "length" DESC,
        title
      LIMIT 10
    LOOP
      RAISE NOTICE '% (% mins)', v_film.title, v_film.length;
    END LOOP;
  END;
$$;

/**
 * Iterate over the result set of a dynamic query.
 * 
 * [<<label>>]
 * FOR record EXECUTE query_expression [ USING query_param, [, ...]]
 * LOOP
 *    statements;
 * END LOOP;
 */
DO $$
  DECLARE
    v_sort_type SMALLINT = 1; -- 1: Title | 2: Release Year
    v_count INT = 10;
    v_film RECORD;
    v_query TEXT;
  
  BEGIN
    v_query = '
      SELECT
        title,
        release_year
      FROM
        film
    ';

    IF v_sort_type = 1 THEN
      v_query = v_query || 'ORDER BY title';
    ELSEIF v_sort_type = 2 THEN
      v_query = v_query || 'ORDER BY release_year';
    ELSE
      RAISE 'Invalid Sort Type %', v_sort_type;
    END IF;

    v_query = v_query || ' LIMIT $1';

    FOR v_film IN EXECUTE v_query USING v_count LOOP
      RAISE NOTICE '% - %', v_film.release_year, v_film.title;
    END LOOP;
  END;
$$;

DO $$
  DECLARE
    v_sort_type SMALLINT = 2; -- 1: Title | 2: Release Year
    v_count INT = 10;
    v_film RECORD;
    v_query TEXT;
  
  BEGIN
    v_query = '
      SELECT
        title,
        release_year
      FROM
        film
    ';

    IF v_sort_type = 1 THEN
      v_query = v_query || 'ORDER BY title';
    ELSEIF v_sort_type = 2 THEN
      v_query = v_query || 'ORDER BY release_year';
    ELSE
      RAISE 'Invalid Sort Type %', v_sort_type;
    END IF;

    v_query = v_query || ' LIMIT $1';

    FOR v_film IN EXECUTE v_query USING v_count LOOP
      RAISE NOTICE '% - %', v_film.release_year, v_film.title;
    END LOOP;
  END;
$$;

