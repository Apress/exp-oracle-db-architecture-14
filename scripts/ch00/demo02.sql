-- Mystat example

column name form a30

@mystat "redo size"

update big_table set owner = lower(owner)
where rownum <= 1000;

@mystat2
