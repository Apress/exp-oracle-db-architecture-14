-- Manual PGA Memory Management, setup

drop table t purge;

set echo on

create table t as select * from all_objects;

exec dbms_stats.gather_table_stats( user, 'T' );
