-- Connections vs. Sessions, part 2

set echo on

select * from v$session where username = 'EODA';

select username, program
  from v$process
  where addr = hextoraw( '00000000727FE9B0' );

select username, sid, serial#, server, paddr, status
  from v$session
  where username = USER;

