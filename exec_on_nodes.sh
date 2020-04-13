#!/bin/sh +x

script=$1
LOG_BASE=$(basename ${1%.*})_`LANG=c date +%y%m%d_%H%M`
echo $LOG_BASE

NODES=(13.115.246.62 3.112.220.124 18.177.146.91 18.179.61.86 54.250.84.83)


for node in ${NODES[@]}
do
  echo ${LOG_BASE}_${node}.log
  #ssh centos@$node 'LC_ALL=C sudo bash -s -x  2>&1' < $script > $LOG_BASE_$node.log
done
