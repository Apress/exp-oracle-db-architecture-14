-- Manual SGA Memory Management

conn / as sysdba
@?/rdbms/admin/dbmspool
grant execute on dbms_shared_pool to eoda;

conn eoda/foo

set echo on

declare
  k varchar2(30);
  ss varchar2(2000);
begin
  for i in 1 .. 100000 loop
    ss := 'create or replace procedure SP' || i || ' is
           a number;
           begin
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
             a := 123456789012345678901234567890;
           end;';
    execute immediate ss;
    k := 'SP' || i;
    sys.dbms_shared_pool.keep(k);
  end loop;
end;
/

select component, parameter, oper_type, oper_mode from v$memory_resize_ops;
