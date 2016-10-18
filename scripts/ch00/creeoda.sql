connect / as sysdba
define username=eoda
define usernamepwd=foo
create user &&username identified by &&usernamepwd;
grant dba to &&username;
grant execute on dbms_stats to &&username;
grant select on V_$STATNAME to &&username;
grant select on V_$MYSTAT   to &&username;
grant select on V_$LATCH    to &&username;
grant select on V_$TIMER    to &&username;
conn &&username/&&usernamepwd
