#!/bin/sh -x

DATE=`LANG=c date +%y%m%d_%H%M`
LOG_BASE=$(basename ${0%.*})_`LANG=c date +%y%m%d_%H%M`
set -x
exec >> ${LOG_BASE}.log 2>&1

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

cat <<EOF > $PATH_TMP$FILE_KADM5_ACL
*/admin@$KDC_REALM	*
EOF

cat <<EOF > $PATH_TMP$FILE_KDC_CONF
defaul_realm=$KDC_REALM

[kdcdefaults]
 kdc_ports = 88
 kdc_tcp_ports = 88

[realms]
 $KDC_REALM = {
  acl_file = /var/kerberos/krb5kdc/kadm5.acl
  dict_file = /usr/share/dict/words
  admin_keytab = /var/kerberos/krb5kdc/kadm5.keytab
  max_life = 24h 0m 0s
  max_renewable_life = 7d 0h 0m 0s
  supported_enctypes = aes256-cts:normal aes128-cts:normal des3-hmac-sha1:normal arcfour-hmac:normal camellia256-cts:normal camellia128-cts:normal des-hmac-sha1:normal des-cbc-md5:normal des-cbc-crc:normal
 }
EOF

cat <<EOF > $PATH_TMP$FILE_KRB5_CONF
# Configuration snippets may be placed in this directory as well
includedir /etc/krb5.conf.d/

[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 dns_lookup_realm = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true
 default_realm = $KDC_REALM
 default_tkt_enctypes = des-cbc-md5 des-cbc-crc des3-cbc-sha1
 default_tgs_enctypes = des-cbc-md5 des-cbc-crc des3-cbc-sha1
 permitted_enctypes = des-cbc-md5 des-cbc-crc des3-cbc-sha1

[realms]
$KDC_REALM = {
  kdc = $hostname:88
  admin_server = $hostname:749
#  default_domain = $KDC_REALM
}

[domain_realm]
  .$domain = $KDC_REALM
  $hostname = $KDC_REALM
EOF


cp ${PATH_KADM5_ACL}${FILE_KADM5_ACL}{,.$DATE.bak}
cp ${PATH_KDC_CONF}${FILE_KDC_CONF}{,.$DATE.bak}
cp ${PATH_KRB5_CONF}${FILE_KRB5_CONF}{,.$DATE.bak}

cp -f ${PATH_TMP}${FILE_KADM5_ACL} ${PATH_KADM5_ACL}${FILE_KADM5_ACL}
cp -f ${PATH_TMP}${FILE_KDC_CONF} ${PATH_KDC_CONF}${FILE_KDC_CONF}
cp -f ${PATH_TMP}${FILE_KRB5_CONF} ${PATH_KRB5_CONF}${FILE_KRB5_CONF}

ls -l ${PATH_KADM5_ACL}${FILE_KADM5_ACL}*
ls -l ${PATH_KDC_CONF}${FILE_KDC_CONF}*
ls -l ${PATH_KRB5_CONF}${FILE_KRB5_CONF}*
