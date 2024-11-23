/*
 * ! Whenever you're dealing with dollar-quoted string constants on DBeaver, highlight the entire
 * ! statement first before executing it.
 * 
 * PL/pgSQL is a block-structured language.
 * Each block has two sections: declarations, and body.
 * 
 * Typically, you use the block label when you want to specify it in the EXIT statement of the block
 * body or to qualify the names of variables declared in the block.
 * */

-- Anonymous Block
-- The DO statement does not belong to the block. It is used to execute an anonymous block.
DO $$
  <<first_block>>
    DECLARE film_count INTEGER = 0;
  
    BEGIN
      SELECT COUNT(*)
      INTO film_count
      FROM film;
      
      RAISE NOTICE 'The number of films is %', film_count;
    END first_block;
$$;

-- SUBBLOCKS
-- Typically, you divide a large block into smaller, more logical subblocks.
DO $$
  <<outer_block>>
    DECLARE x INTEGER = 0;
    BEGIN
      x = x + 1;
      
      <<inner_block>>
        DECLARE y INTEGER = 2;
        BEGIN
          y = x + y;
          RAISE NOTICE 'x = % | y = %', x, y;
        END
      inner_block;

    END
  outer_block;
$$;
