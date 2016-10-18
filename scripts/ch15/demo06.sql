-- Reading and Filtering Compressed Files in a Directory Tree, search_dir2.bsh

!mkdir /tmp/base
!mkdir /tmp/base/base2a
!mkdir /tmp/base/base2b

!echo 'base col1,base col2' | gzip > /tmp/base/filebase.csv.gz
!echo 'base2a col1,base2a col2' | gzip > /tmp/base/base2a/filebase2a.csv.gz
!echo 'base2b col1,base2b col2' | gzip > /tmp/base/base2b/filebase2b.csv.gz

create or replace directory exec_dir as '/orahome/oracle/bin';
create or replace directory data_dir as '/tmp';

drop table csv2;

create table csv2
  ( col1 varchar2(20)
   ,col2 varchar2(20)
  )
  organization external
  (
   type oracle_loader
   default directory data_dir
   access parameters
    (
      records delimited by newline
      preprocessor exec_dir:'search_dir2.bsh'
      fields terminated by ',' ldrtrim
    )
    location
    (
      data_dir:'base'
    )
)
/

select * from csv2;
