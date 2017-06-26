#!/bin/bash
# Copy and edit maven settings file.

SCRIPT_DIR=`dirname "$0"`
pushd "${SCRIPT_DIR}"
cp ~/.m2/settings.xml ./

sed -i -e 's|</profiles>|\
  <profile>\
    <id>archetype</id>\
    <repositories>\
      <repository>\
        <id>archetype-releases</id>\
        <url>http://repo.terasoluna.org/nexus/content/repositories/terasoluna-gfw-releases</url>\
      </repository>\
      <repository>\
        <id>archetype-snapshots</id>\
        <url>http://repo.terasoluna.org/nexus/content/repositories/terasoluna-gfw-snapshots</url>\
      </repository>\
    </repositories>\
  </profile>\
</profiles>|g' ./settings.xml

popd
