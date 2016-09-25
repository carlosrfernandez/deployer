#!/bin/bash
set -euo pipefail

container="<% docker.name %>"

docker kill ${container}
docker rm   ${container}
