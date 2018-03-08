#!/bin/bash
# Convert infra property definitions.
# Required variables:
#   ${ARTIFACT_ID}=Artifact ID of tutorial project.
#   ${HOST_IP}=IP address for access to this web application.
#   ${APSRV_WEB_PORT}=Port number for access to this web application.
# Parameters:
#   $1 : (Optional) Target project path to convert.

APPLICATION_DIR=$1
if test -n $APPLICATION_DIR; then
  pushd "$APPLICATION_DIR"
fi

# env/-infra.properties
ENV_INFRA_PROPERTIES=`find ./${ARTIFACT_ID}-env -type f -name "${ARTIFACT_ID}-infra.properties"`
for i in ${ENV_INFRA_PROPERTIES} ; do echo -e " 
mail.host=localhost
mail.port=3025
mail.from=info@example.com
mail.subject=Password Reissue URL

app.applicationBaseUrl = http://${HOST_IP}:${APSRV_WEB_PORT}/${ARTIFACT_ID}-web" >>$i ; done

if test -n $APPLICATION_DIR; then
  popd
fi
