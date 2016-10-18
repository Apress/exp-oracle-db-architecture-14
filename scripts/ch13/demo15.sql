-- Sliding Windows and Indexes

drop table fy_2014 purge;
drop table fy_2016 purge;
drop table partitioned purge;

set echo on

CREATE TABLE partitioned
  ( timestamp date,
    id        int
  )
  PARTITION BY RANGE (timestamp)
  (
  PARTITION fy_2014 VALUES LESS THAN
  ( to_date('01-jan-2015','dd-mon-yyyy') ) ,
  PARTITION fy_2015 VALUES LESS THAN
  ( to_date('01-jan-2016','dd-mon-yyyy') )
  )
/

insert into partitioned partition(fy_2014)
  select to_date('31-dec-2014','dd-mon-yyyy')-mod(rownum,360), rownum
  from dual connect by level <= 70000
/

insert into partitioned partition(fy_2015)
  select to_date('31-dec-2015','dd-mon-yyyy')-mod(rownum,360), rownum
  from dual connect by level <= 70000
/

create index partitioned_idx_local
  on partitioned(id)
  LOCAL
/

create index partitioned_idx_global
  on partitioned(timestamp)
  GLOBAL
/

create table fy_2014 ( timestamp date, id int );
create index fy_2014_idx on fy_2014(id);

create table fy_2016 ( timestamp date, id int );

insert into fy_2016
  select to_date('31-dec-2016','dd-mon-yyyy')-mod(rownum,360), rownum
  from dual connect by level <= 70000
 /

create index fy_2016_idx on fy_2016(id) nologging;

alter table partitioned
  exchange partition fy_2014
  with table fy_2014
  including indexes
  without validation
/

alter table partitioned drop partition fy_2014;

alter table partitioned
  add partition fy_2016
  values less than ( to_date('01-jan-2017','dd-mon-yyyy') )
/

alter table partitioned
  exchange partition fy_2016
  with table fy_2016
  including indexes
  without validation
/

select count(*) from fy_2014;
select count(*) from partitioned partition(fy_2015);
select count(*) from partitioned partition(fy_2016);

column index_name format a25
select index_name, status from user_indexes;

-- should throw an error
select /*+ index( partitioned PARTITIONED_IDX_GLOBAL ) */ count(*)
  from partitioned
  where timestamp between to_date( '01-mar-2016', 'dd-mon-yyyy' )
  and to_date( '31-mar-2016', 'dd-mon-yyyy' );

explain plan for select count(*)
    from partitioned
    where timestamp between to_date( '01-mar-2016', 'dd-mon-yyyy' )
    and to_date( '31-mar-2016', 'dd-mon-yyyy' );

select * from table(dbms_xplan.display(null,null,'BASIC +PARTITION'));
