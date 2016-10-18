-- Temporary Tables, example 3

set echo on

drop table gtt;

create global temporary table gtt
as
select * from scott.emp where 1=0;
 
insert into gtt select * from scott.emp;
 
set autotrace traceonly explain
select * from gtt;

set autotrace off;
