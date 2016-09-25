#!/bin/bash
set -euo pipefail

build="<% cli.build %>"
image="<% docker.image %>:<% version.major %>.<% version.minor %>"
container="<% docker.image %>"
volume_aws="<% volumes.aws %>"
volume_ssl="<% volumes.ssl %>"
folder_aws="<% folders.aws %>"
folder_ssl="<% folders.ssl %>"

docker kill ${container} 2&> /dev/null || true
docker rm   ${container} 2&> /dev/null || true

docker volume create --name ${volume_aws} > /dev/null
docker volume create --name ${volume_ssl} > /dev/null

docker run -d \
  -v ${volume_aws}:${folder_aws} \
  -v ${volume_ssl}:${folder_ssl} \
  --name ${container} \
  ${image}.${build}
