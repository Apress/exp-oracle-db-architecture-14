#!/bin/bash

for i in `seq 1 $*`
do
  ./t &
done
wait
