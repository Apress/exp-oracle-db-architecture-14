-- Setting Values in SPFILEs

set echo on

select name
   from v$parameter
   where issys_modifiable='DEFERRED'
/

alter system set sort_area_size = 65536;

alter system set sort_area_size = 65536 deferred;

alter system set pga_aggregate_target=512m;

alter system set pga_aggregate_target=512m
  comment = 'Changed 14-aug-2013, AWR recommendation';

column value format a20 
column update_comment format a50

select value, update_comment
  from v$parameter
  where name = 'pga_aggregate_target'
/

-- Unsetting Values in SPFILEs

alter system reset sort_area_size scope=spfile ;

connect / as sysoper;
create pfile='/tmp/pfile.tst' from spfile;

-- Creating PFILEs from SPFILEs

connect / as sysdba

create pfile='init_14_aug_2013_ora12cr1.ora' from spfile;

alter system set pga_aggregate_target=512m
  comment = 'Changed 14-aug-2013, AWR recommendation';
