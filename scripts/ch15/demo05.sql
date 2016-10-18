-- Reading and Filtering Compressed Files in a Directory Tree, search_dir.bsh

host mkdir /tmp/base
host mkdir /tmp/base/base2a
host mkdir /tmp/base/base2b

host echo 'base col1,base col2' | gzip > /tmp/base/filebase.csv.gz
host echo 'base2a col1,base2a col2' | gzip > /tmp/base/base2a/filebase2a.csv.gz
host echo 'base2b col1,base2b col2' | gzip > /tmp/base/base2b/filebase2b.csv.gz

create or replace directory exec_dir as '/orahome/oracle/bin';
create or replace directory data_dir as '/tmp';

drop table csv;

create table csv
  ( col1 varchar2(20)
  )
  organization external
  (
   type oracle_loader
   default directory data_dir
   access parameters
    (
      records delimited by newline
      preprocessor exec_dir:'search_dir.bsh'
      fields terminated by ',' ldrtrim
    )
    location
    (
      data_dir:'base'
    )
)
/

select * from csv;

create or replace directory data_dir as '/tmp/base';
alter table csv location( 'base2a' );

select * from csv;

-- Finding largest files
create or replace directory exec_dir as '/orahome/oracle/bin';
create or replace directory data_dir as '/';

create table flf (fname varchar2(200), bytes number)
  organization external (
    type oracle_loader
    default directory exec_dir
    access parameters
    ( records delimited by newline
      preprocessor exec_dir:'flf.bsh'
      fields terminated by whitespace ldrtrim)
    location (data_dir:'u01'));

