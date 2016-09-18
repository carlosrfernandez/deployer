#!/bin/bash
set -euo pipefail

id="<% cli.id %>"
image="<% deployer.image %>:<% deployer.major %>.<% deployer.minor %>"
container="<% deployer.name %>"

docker kill ${container} 2&> /dev/null || true
docker rm   ${container} 2&> /dev/null || true
docker run -d         \
  --name ${container} \
  ${image}.${id}
