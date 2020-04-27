#!/bin/bash -x

#LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log
#exec > ./$LOG_FILE 2>&1

yum -y install krb5-workstation krb5-libs
