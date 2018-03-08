#!/bin/bash
# Create Session tutorial initial app.
# Required variables:
#   ${ARCHETYPE_ARTIFACT_ID}=Artifact ID of blank project's archetype.
#   ${ARCHETYPE_VERSION}=Version of blank project's archetype.
#   ${GROUP_ID}=Group ID of tutorial project. This project's GROUP_ID must be set 'todo'.
#   ${ARTIFACT_ID}=Artifact ID of tutorial project.
#   ${VERSION}=Version of tutorial project.

echo "create version is ${VERSION}."

SCRIPT_DIR=`dirname "$0"`
TARGET_DIR=${SCRIPT_DIR}/../target-project

# create dir for work
rm -rf "${TARGET_DIR}/${ARTIFACT_ID}"
mkdir "$TARGET_DIR"
pushd "$TARGET_DIR"

bash ../../common/scripts/generate-project.sh

bash ../scripts/copy-sources.sh

bash ../../common/scripts/convert-common-test.sh `pwd`

pushd "$ARTIFACT_ID"

bash ../../scripts/convert-session-init-css.sh `pwd`

bash ../../scripts/convert-session-init-jsp.sh `pwd`

bash ../../scripts/convert-session-init-properties.sh `pwd`

bash ../../scripts/convert-session-init-xml.sh `pwd`

bash ../../scripts/convert-session-init-test.sh `pwd`

popd

popd
