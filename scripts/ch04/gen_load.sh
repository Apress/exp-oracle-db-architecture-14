#!/bin/bash
for i in {1..25}
do
        sqlplus eoda/foo @gen_load.sql &
done
