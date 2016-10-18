-- What Does a COMMIT Do?
drop table test purge;

create table test
  ( id          number,
    code        varchar2(20),
    descr       varchar2(20),
    insert_user varchar2(30),
    insert_date date
  )
/
