-- Alert Log

create or replace
  directory data_dir
  as
  '/orahome/app/oracle/diag/rdbms/ora12cr1/ORA12CR1/trace/'
/

drop table alert_log;

CREATE TABLE alert_log
  (
      text_line varchar2(4000)
  )
  ORGANIZATION EXTERNAL
  (
      TYPE ORACLE_LOADER
      DEFAULT DIRECTORY data_dir
      ACCESS PARAMETERS
      (
          records delimited by newline
          fields
      )
      LOCATION
      (
          'alert_ORA12CR1.log'
      )
  )
  reject limit unlimited
/

select to_char(last_time,'dd-mon-yyyy hh24:mi') shutdown,
         to_char(start_time,'dd-mon-yyyy hh24:mi') startup,
         round((start_time-last_time)*24*60,2) mins_down,
         round((last_time-lag(start_time) over (order by r)),2) days_up,
         case when (lead(r) over (order by r) is null )
              then round((sysdate-start_time),2)
          end days_still_up
    from (
  select r,
         to_date(last_time, 'Dy Mon DD HH24:MI:SS YYYY') last_time,
         to_date(start_time,'Dy Mon DD HH24:MI:SS YYYY') start_time
    from (
  select r,
         text_line,
         lag(text_line,1) over (order by r) start_time,
         lag(text_line,2) over (order by r) last_time
    from (
  select rownum r, text_line
    from alert_log
   where text_line like '___ ___ __ __:__:__ 20__'
      or text_line like 'Starting ORACLE instance %'
             )
             )
   where text_line like 'Starting ORACLE instance %'
         )
/

column value new_val V

select value from v$diag_info where name = 'Diag Alert';
