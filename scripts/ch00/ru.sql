SET LINESIZE 150;
SET SERVEROUTPUT on SIZE 1000000 FORMAT WRAPPED;
--
declare
--
l_rows    number;
--
begin
l_rows := unloader.run
( p_cols       => '*',
p_town       => 'EODA',
p_tname      => 'BIG_TABLE',
p_mode       => 'truncate',
p_dbdir      => 'UNLOADER',
p_filename   => 'unload_file',
p_separator  => ',',
p_enclosure  => '"',
p_terminator => '|',
p_ctl        => 'YES',
p_header     => 'NO' );
--
dbms_output.put_line( to_char(l_rows) || ' rows extracted to ascii file' );
--
end;
/
