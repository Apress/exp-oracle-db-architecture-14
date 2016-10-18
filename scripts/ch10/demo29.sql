-- Temporary Tables, example 4

set echo on

drop table emp cascade constraints;
drop table gtt1;
drop table gtt2;

create table emp as select * from scott.emp;
 
create global temporary table gtt1 ( x number )
on commit preserve rows;
 
create global temporary table gtt2 ( x number )
on commit delete rows;
 
insert into gtt1 select user_id from all_users;
 
insert into gtt2 select user_id from all_users;
 
exec dbms_stats.gather_schema_stats( user );
 
column table_name format a30
column last_analyzed format a14

select table_name, last_analyzed, num_rows from user_tables;

insert into gtt2 select user_id from all_users;
 
exec dbms_stats.gather_schema_stats( user, gather_temp=>TRUE );
 
select table_name, last_analyzed, num_rows from user_tables;
