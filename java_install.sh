#!/bin/bash -x

exec >> ./$(basename $0%.*)_`LANG=c date +%Y%m%d_%H%M`.log 2>&1

yum install -y oracle-j2sdk1.8

ls -l /usr/java/jdk1.8.*
