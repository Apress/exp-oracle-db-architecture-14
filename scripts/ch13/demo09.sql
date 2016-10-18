-- Virtual Column Partitioning

drop table res purge;

set echo on

create table res(reservation_code varchar2(30));

insert into res
select chr(64+(round(dbms_random.value(1,4)))) || level
from dual connect by level < 100000;

drop table res;

create table res(
  reservation_code varchar2(30),
  region as (substr(reservation_code,1,1))
  )
  partition by list (region)
(partition p1 values('A'),
 partition p2 values('B'),
 partition p3 values('C'),
 partition p4 values('D'));

create index r1 on res(reservation_code) local;

insert into res (reservation_code)
select chr(64+(round(dbms_random.value(1,4)))) || level
from dual connect by level < 100000;

exec dbms_stats.gather_table_stats(user,'RES');

explain plan for select count(*) from res where reservation_code='A';
select * from table(dbms_xplan.display(null, null, 'BASIC +PARTITION'));
