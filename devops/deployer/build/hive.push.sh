#!/bin/bash
set -euo pipefail

id="<% cli.id %>"
image="<% deployer.image %>:<% deployer.major %>.<% deployer.minor %>"

docker push ${image}
docker push ${image}.${id}
