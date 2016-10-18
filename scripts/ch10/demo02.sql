-- Freelists

set echo on

-- You may have to modify these two create tablespace statements for your
-- environment. These assume OMF are being used.

create tablespace mssm
  datafile size 1m autoextend on next 1m
  segment space management manual;

create tablespace assm
  datafile size 1m autoextend on next 1m
  segment space management auto;

drop table t purge;

create table t ( x int, y char(50) )
-- storage( freelists 5 )
-- tablespace mssm;
tablespace assm; 

set ech off
!echo begin for i in 1 .. 100000 loop insert into t values \(i,\'x\'\)\; end loop\; commit\; end\; > test.sql
!echo / >> test.sql
!echo exit >> test.sql

!echo \#\!/bin/bash > test.sh
!echo sqlplus eoda/foo @test.sql \&>> test.sh
!echo sqlplus eoda/foo @test.sql \&>> test.sh
!echo sqlplus eoda/foo @test.sql \&>> test.sh
!echo sqlplus eoda/foo @test.sql \&>> test.sh
!echo sqlplus eoda/foo @test.sql \&>> test.sh
!echo wait >> test.sh
set echo on

!chmod 755 test.sh

exec statspack.snap
!/bin/bash ./test.sh
exec statspack.snap
@?/rdbms/admin/spreport
