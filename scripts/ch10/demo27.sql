-- Temporary Tables, example 2

set echo on

create global temporary table gtt 
as
select * from scott.emp where 1=0;
 
insert into gtt select * from scott.emp;

set autotrace traceonly explain
select /*+ first_rows */ * from gtt;
select /*+ first_rows dynamic_sampling(gtt 2) */ * from gtt;

set autotrace off
