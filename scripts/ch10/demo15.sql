-- Index Clustered Tables, example 3

set echo on

select rowid from emp
intersect
select rowid from dept;
