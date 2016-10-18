-- Initial Transaction Slots, 1 or 2?

connect eoda/foo
drop table t purge;

set echo on

create table t ( x int );
select ini_trans from user_tables where table_name = 'T';

insert into t values ( 1 );

column b new_val B
column f new_val F

select dbms_rowid.ROWID_BLOCK_NUMBER(rowid) B,
       dbms_rowid.ROWID_TO_ABSOLUTE_FNO( rowid, user, 'T' ) F
  from t;

alter system dump datafile &F block &B;

column trace new_val TRACE

select c.value || '/' || d.instance_name || '_ora_' || a.spid || '.trc' trace
  from v$process a, v$session b, v$parameter c, v$instance d
 where a.addr = b.paddr
   and b.audsid = userenv('sessionid')
   and c.name = 'user_dump_dest'
/

disconnect
edit &TRACE
connect eoda/foo
