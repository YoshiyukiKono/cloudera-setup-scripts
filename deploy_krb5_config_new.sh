#!/bin/sh -x

DATE=`LANG=c date +%y%m%d_%H%M`
LOG_BASE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`
#set -x
#exec >> ${LOG_BASE}.log 2>&1

PATH_TMP=./
FILE_KRB5_CONF=krb5.conf
PATH_KRB5_CONF=/etc/

cp ${PATH_KRB5_CONF}${FILE_KRB5_CONF}{,.$DATE.bak}

cp -f ${PATH_TMP}${FILE_KRB5_CONF} ${PATH_KRB5_CONF}${FILE_KRB5_CONF}

ls -l ${PATH_KRB5_CONF}${FILE_KRB5_CONF}*
