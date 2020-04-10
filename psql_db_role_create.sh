#!/bin/bash -x

LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log
exec > ./$LOG_FILE 2>&1

SQL=$(cat << EOD
CREATE ROLE scm LOGIN PASSWORD 'scm';
CREATE ROLE amon LOGIN PASSWORD 'amon';
CREATE ROLE rman LOGIN PASSWORD 'rman';
CREATE ROLE hue LOGIN PASSWORD 'hue';
CREATE ROLE hive LOGIN PASSWORD 'hive';
CREATE ROLE sentry LOGIN PASSWORD 'sentry';
CREATE ROLE nav LOGIN PASSWORD 'nav';
CREATE ROLE navms LOGIN PASSWORD 'navms';
CREATE ROLE oozie LOGIN PASSWORD 'oozie';
CREATE DATABASE scm OWNER scm ENCODING 'UTF8';
CREATE DATABASE amon OWNER amon ENCODING 'UTF8';
CREATE DATABASE rman OWNER rman ENCODING 'UTF8';
CREATE DATABASE hue OWNER hue ENCODING 'UTF8';
CREATE DATABASE metastore OWNER hive ENCODING 'UTF8';
CREATE DATABASE sentry OWNER sentry ENCODING 'UTF8';
CREATE DATABASE nav OWNER nav ENCODING 'UTF8';
CREATE DATABASE navms OWNER navms ENCODING 'UTF8';
CREATE DATABASE oozie OWNER oozie ENCODING 'UTF8';
ALTER DATABASE metastore SET standard_conforming_strings=off;
ALTER DATABASE oozie SET standard_conforming_strings=off;
EOD
)

echo ${SQL} | sudo -u postgres psql | tee -a postgres_.log
