#!/bin/bash -x

LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log
exec > ./$LOG_FILE 2>&1

yum install -y oracle-j2sdk1.8

yum install -y cloudera-manager-daemons cloudera-manager-agent cloudera-manager-server

JAVA_HOME=/usr/java/jdk1.8.0_181-cloudera /opt/cloudera/cm-agent/bin/certmanager setup --configure-services
