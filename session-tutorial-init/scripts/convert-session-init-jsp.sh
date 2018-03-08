#!/bin/bash
# Convert jsp resource(s) on blank project.
# Parameters:
#   $1 : (Optional) Target project path to convert.

APPLICATION_DIR=$1
if test -n $APPLICATION_DIR; then
  pushd "$APPLICATION_DIR"
fi

# include.jsp
find ./ -type f -name 'include.jsp' | xargs sed -i -e 's|<%@ page session="false"|<%@ page session="true"|'

if test -n $APPLICATION_DIR; then
  popd
fi
