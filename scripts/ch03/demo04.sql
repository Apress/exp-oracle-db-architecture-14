-- Tagging Trace Files

alter session set tracefile_identifier = 'Look_For_Me';
exec dbms_output.put_line( scott.get_param( 'user_dump_dest' ) )
!ls /home/ora12cr1/app/ora12cr1/diag/rdbms/ora12cr1/ora12cr1/trace/*Look_For_Me*
