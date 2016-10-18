LOAD DATA
INFILE *
REPLACE
INTO TABLE LOB_DEMO
( owner       position(14:19),
  time_stamp  position(31:42) date "Mon DD HH24:MI",
  filename    position(44:100),
  data        LOBFILE(filename) TERMINATED BY EOF
)
BEGINDATA
-rwxr-xr-x 1 oracle dba 14889 Jul 22 22:01 demo1.log_xt
-rwxr-xr-x 1 oracle dba   123 Jul 22 20:07 demo2.ctl
-rwxr-xr-x 1 oracle dba   712 Jul 23 12:11 demo.bad
-rwxr-xr-x 1 oracle dba  8136 Mar  9 12:36 demo.control_files
-rwxr-xr-x 1 oracle dba   825 Jul 23 12:26 demo.ctl
-rwxr-xr-x 1 oracle dba  1681 Jul 23 12:26 demo.log
-rw-r----- 1 oracle dba   118 Jul 23 12:52 dl.sql
-rwxr-xr-x 1 oracle dba   127 Jul 23 12:05 lob_demo.sql
-rwxr-xr-x 1 oracle dba   171 Mar 10 13:53 p.bsh
-rwxr-xr-x 1 oracle dba   327 Mar 10 11:10 prime.bsh
-rwxr-xr-x 1 oracle dba    24 Mar  6 12:09 run_df.sh
