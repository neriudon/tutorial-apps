#!/bin/bash
# Convert selenium test resource(s) on blank project.
# Required variables:
#   ${ARCHETYPE_ARTIFACT_ID}=Artifact ID of blank project's archetype.
#   ${ARTIFACT_ID}=Artifact ID of tutorial project.

TARGET_DIR=$1
if test -n "${TARGET_DIR}/${ARTIFACT_ID}"; then
  pushd "${TARGET_DIR}/${ARTIFACT_ID}"
fi

find ./pom.xml | xargs sed -i -e 's|</dependencies>|    <dependency>\
                <groupId>io.github.bonigarcia</groupId>\
                <artifactId>webdrivermanager</artifactId>\
                <version>${webdrivermanager.version}</version>\
            </dependency>|'

find ./pom.xml | xargs sed -i -e 's|</properties>|    <webdrivermanager.version>1.6.2</webdrivermanager.version>\
    </properties>|'

if test -n "${TARGET_DIR}/${ARTIFACT_ID}"; then
  popd
fi
