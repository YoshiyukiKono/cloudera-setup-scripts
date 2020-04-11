#!/bin/bash -x

LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log
exec > ./$LOG_FILE 2>&1

PG_HBA=/var/lib/pgsql/data/pg_hba.conf
PG_CONF=/var/lib/pgsql/data/postgresql.conf

sed -i.bak \
 -e 's/^\(host all all 127.0.0.1\/32 ident\)/host all all 127.0.0.1\/32 md5\n\1/g' \
 $PG_HBA

sed -i.bak \
 -e 's/\(.*shared_buffers = .*\)/#\1\nshared_buffers = 256MB/g' \
 -e 's/\(.*wal_buffers = .*\)/#\1\nwal_buffers = 8MB /g' \ 
 -e 's/\(.*checkpoint_segments = .*\)/#\1\ncheckpoint_segments = 16/g' \ 
 -e 's/\(.*checkpoint_completion_target = .*\)/#\1\ncheckpoint_completion_target = 0.9/g' \
 $PG_CONF

# -e 's/max_connection/max_connection/g' \
# -e 's/max_wal_size = .*/max_wal_size/g' \ 

grep -e "ident$" -e "md5$" $PG_HBA

grep -e max_connection -e shared_buffers -e wal_buffers -e checkpoint_segments -e checkpoint_completion_target $PG_CONF

systemctl enable postgresql
systemctl restart postgresql
systemctl status postgresql
