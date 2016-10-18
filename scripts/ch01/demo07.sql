-- Flashback

conn / as sysdba
grant execute on dbms_flashback to scott;

conn scott/tiger

set echo on

variable scn number
exec :scn := dbms_flashback.get_system_change_number;
print scn

select count(*) from emp;

delete from emp;

select count(*) from emp;

select count(*),
         :scn then_scn,
         dbms_flashback.get_system_change_number now_scn
from emp as of scn :scn;

alter table emp enable row movement;
flashback table emp to scn :scn;

select cnt_now, cnt_then,
         :scn then_scn,
         dbms_flashback.get_system_change_number now_scn
    from (select count(*) cnt_now from emp),
         (select count(*) cnt_then from emp as of scn :scn)
/
