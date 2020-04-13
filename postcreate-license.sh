#!/bin/sh -x

CM_USERNAME=admin
CM_PASSWORD=admin
DEPLOYMENT_PORT=7180
#DEPLOYMENT_PORT=7183

DEPLOYMENT_HOST=$1

DEPLOYMENT_HOST_PORT=$DEPLOYMENT_HOST:$DEPLOYMENT_PORT

cp ~/my_cloudera_license.txt .

curl --insecure -X POST -F 'license=@my_cloudera_license.txt' -u ${CM_USERNAME}:${CM_PASSWORD} http://${DEPLOYMENT_HOST_PORT}/api/v19/cm/license
#curl --insecure -X POST -F 'license=@my_cloudera_license.txt' -u ${CM_USERNAME}:${CM_PASSWORD} https://${DEPLOYMENT_HOST_PORT}/api/v19/cm/license

exit 0
