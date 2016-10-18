-- The Black Box Approach

drop table t purge;

set echo on

create table t
  ( processed_flag varchar2(1)
);

create bitmap index
  t_idx on t(processed_flag);

insert into t values ( 'N' );

declare
  pragma autonomous_transaction;
begin
  insert into t values ( 'N' );
  commit;
end;
/
