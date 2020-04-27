#!/bin/sh -x

DATE=`LANG=c date +%y%m%d_%H%M`
LOG_BASE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`
#set -x
#exec >> ${LOG_BASE}.log 2>&1

PATH_TMP=./tmp/
FILE_KADM5_ACL=kadm5.acl
FILE_KDC_CONF=kdc.conf
FILE_KRB5_CONF=krb5.conf

PATH_KADM5_ACL=/var/kerberos/krb5kdc/
PATH_KDC_CONF=/var/kerberos/krb5kdc/
PATH_KRB5_CONF=/etc/

domain="$(hostname -d)"
hostname="$(hostname -f)"
KDC_REALM="HADOOP" 

kdb5_util create -r $KDC_REALM -s
