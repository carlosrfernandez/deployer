#!/bin/bash
set -euo pipefail

build="<% cli.build %>"
image="<% docker.image %>:<% version.major %>.<% version.minor %>"

docker push ${image}
docker push ${image}.${build}
