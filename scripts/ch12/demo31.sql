-- BFILEs

drop table t purge;

set echo on

create table t
  ( id       int primary key,
    os_file  bfile
)
/
