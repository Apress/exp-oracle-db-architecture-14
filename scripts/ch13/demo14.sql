-- Global Indexes

drop table partitioned purge;

set echo on

CREATE TABLE partitioned
  ( timestamp date,
    id        int
  )
  PARTITION BY RANGE (timestamp)
  (
  PARTITION part_1 VALUES LESS THAN
  ( to_date('01-jan-2014','dd-mon-yyyy') ) ,
  PARTITION part_2 VALUES LESS THAN
  ( to_date('01-jan-2015','dd-mon-yyyy') )
  )
/

create index partitioned_index
  on partitioned(id)
  GLOBAL
  partition  by range(id)
  (
  partition part_1 values less than(1000),
  partition part_2 values less than (MAXVALUE)
  )
/

alter table partitioned add constraint
  partitioned_pk
  primary key(id)
/

-- should throw an error
drop index partitioned_index;

-- should throw an error
create index partitioned_index2
  on partitioned(timestamp,id)
  GLOBAL
  partition  by range(id)
  (
  partition part_1 values less than(1000),
  partition part_2 values less than (MAXVALUE)
)
/
