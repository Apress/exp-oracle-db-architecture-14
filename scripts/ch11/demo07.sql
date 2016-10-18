-- Bitmap Indexes 

set echo on

create BITMAP index job_idx on emp(job);

select count(*) from emp where job = 'CLERK' or job = 'MANAGER';

select * from emp where job = 'CLERK' or job = 'MANAGER';
