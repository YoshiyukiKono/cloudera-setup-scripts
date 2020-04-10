#!/bin/bash -x

LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log

exec > ./$LOG_FILE 2>&1

/opt/cloudera/cm/schema/scm_prepare_database.sh postgresql scm scm

if [[ ! -e /etc/cloudera-scm-server/db.mgmt.properties ]]; then
  mv /etc/cloudera-scm-server/db.mgmt.properties .
fi
