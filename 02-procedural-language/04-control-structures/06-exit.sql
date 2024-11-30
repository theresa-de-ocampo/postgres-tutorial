/**
 * Besides terminating a loop, you can use the exit statement to exit a block specified by the
 * BEGIN ... END keywords.
 */

DO $$
  <<outer_block>>
    BEGIN
      <<inner_block>>
        BEGIN
          EXIT inner_block;
          RAISE NOTICE 'Unreachable Code';
        END
      inner_block;

      RAISE NOTICE 'End of Outer Block';
    END
  outer_block;
$$;