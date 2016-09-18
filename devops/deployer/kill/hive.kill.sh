#!/bin/bash
set -euo pipefail

container="<% deployer.name %>"

docker kill ${container}
docker rm   ${container}
