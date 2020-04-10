#!/bin/bash -x

LOG_FILE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`.log
exec > ./$LOG_FILE 2>&1

yum install -y wget

echo $LOGIN
echo $PASSWORD

rpm -qa gpg-pubkey*

REPO_FILE_URL=https://$LOGIN:$PASSWORD@archive.cloudera.com/p/cm6/6.3.3/redhat7/yum/cloudera-manager.repo

wget $REPO_FILE_URL -P /etc/yum.repos.d/

rpm --import https://$LOGIN:$PASSWORD@archive.cloudera.com/p/cm6/6.3.3/redhat7/yum/RPM-GPG-KEY-cloudera


rpm -qa gpg-pubkey*

rpm -qi gpg-pubkey-b0b19c9f-5b16fa8b

sed -i -e "s/^baseurl=https:\/\//baseurl=https:\/\/$LOGIN:$PASSWORD@/" /etc/yum.repos.d/cloudera-manager.repo
sed -i -e "s/^gpgkey=https:\/\//gpgkey=https:\/\/$LOGIN:$PASSWORD@/" /etc/yum.repos.d/cloudera-manager.repo
