-- Myth: Space Is Never Reused in an Index

set echo on

select count(*) from big_table;

declare
      l_freelist_blocks number;
begin
      dbms_space.free_blocks
      (segment_owner => user,
       segment_name => 'BIG_TABLE_PK',
       segment_type => 'INDEX',
       freelist_group_id => 0,
       free_blks => l_freelist_blocks );
      dbms_output.put_line( 'blocks on freelist = ' || l_freelist_blocks );
end;
/

select leaf_blocks from user_indexes where index_name = 'BIG_TABLE_PK';

delete from big_table where id <= 250000;
commit;

declare
      l_freelist_blocks number;
begin
      dbms_space.free_blocks
      ( segment_owner => user,
        segment_name => 'BIG_TABLE_PK',
        segment_type => 'INDEX',
        freelist_group_id => 0,
        free_blks => l_freelist_blocks );
        dbms_output.put_line( 'blocks on freelist = ' || l_freelist_blocks );
      dbms_stats.gather_index_stats ( user, 'BIG_TABLE_PK' );
end;
/

select leaf_blocks from user_indexes where index_name = 'BIG_TABLE_PK';
