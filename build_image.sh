#!/bin/bash

info () {
  echo "To build the container image pass version number as \$1, noting that latest is always applied too..."
  echo "To build the container with tag v0.1 and latest run the following:"
  echo "Run: \"./build_image.sh v0.1\""
  exit 1
}

if [ -z "$1" ]; then
  info
fi

docker build --network="lan" --build-arg org_label_schema_version=$1 --build-arg org_label_schema_build_date=$(date -u +'%Y-%m-%dT%H:%M:%SZ') -t xitation/tensorflow-hub-make_image_classifier:latest -t xitation/tensorflow-hub-make_image_classifier:$1 .
