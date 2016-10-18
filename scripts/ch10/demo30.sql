-- Temporary Tables, example 5

set echo on

drop table t;

create global temporary table t ( x int, y varchar2(100) );
--on commit preserve rows;

begin
     dbms_stats.set_table_stats( ownname => USER,
                                 tabname => 'T',
                                 numrows => 500,
                                 numblks => 7,
                                 avgrlen => 100 );
end;
/

column table_name format a10

select table_name, num_rows, blocks, avg_row_len
from user_tables
where table_name = 'T';

select table_name, temporary, duration from user_tables where table_name='T';
