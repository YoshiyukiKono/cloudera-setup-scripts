#!/bin/bash -x

exec >> ./$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log 2>&1

yum install -y postgresql-server

#yum install -y python-pip

yum install -y epel-release
yum install -y python-pip --enablerepo=epel

pip install psycopg2==2.7.5 --ignore-installed

echo 'LC_ALL="en_US.UTF-8"' >> /etc/locale.conf

su -l postgres -c "postgresql-setup initdb"



