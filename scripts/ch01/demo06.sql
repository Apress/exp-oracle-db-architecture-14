-- Multi-versioning

drop table t purge;

set echo on

create table t
  as
  select username, created
    from all_users
/

set autoprint off
variable x refcursor;
begin
      open :x for select * from t;
end;
/

declare
      pragma autonomous_transaction;
      -- you could do this in another
      -- sqlplus session as well, the
      -- effect would be identical
begin
      delete from t;
      commit;
end;
/

column username format a20
column created format a20
print x
