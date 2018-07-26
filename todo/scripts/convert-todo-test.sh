#!/bin/bash
# Convert selenium test resource(s) on blank project.
# Required variables:
#   ${ARCHETYPE_ARTIFACT_ID}=Artifact ID of blank project's archetype.
#   ${ARTIFACT_ID}=Artifact ID of tutorial project.
# Parameters:
#   $1 : (Optional) Target project path to convert.

TARGET_DIR=$1
if test -n "${TARGET_DIR}/${ARTIFACT_ID}"; then
  pushd "${TARGET_DIR}/${ARTIFACT_ID}"
fi

# selenium/pom.xml
find ./${ARTIFACT_ID}-selenium -type f -name 'pom.xml' | xargs sed -i -e 's|</dependencies>|    <dependency>\
                <groupId>io.github.bonigarcia</groupId>\
                <artifactId>webdrivermanager</artifactId>\
                <scope>test</scope>\
            </dependency>\
            <dependency>\
                <groupId>com.google.guava</groupId>\
                <artifactId>guava</artifactId>\
                <scope>test</scope>\
            </dependency>\
\
        </dependencies>|'

# selenium.properties
if test `echo $ARCHETYPE_ARTIFACT_ID | grep multi`;then
  find ./ -type f -name 'selenium.properties' | xargs sed -i -e "s|selenium.contextName=|selenium.contextName=${ARTIFACT_ID}-web|"
else
  find ./ -type f -name 'selenium.properties' | xargs sed -i -e "s|selenium.contextName=|selenium.contextName=${ARTIFACT_ID}|"
fi

if test -n "${TARGET_DIR}/${ARTIFACT_ID}"; then
  popd
fi
