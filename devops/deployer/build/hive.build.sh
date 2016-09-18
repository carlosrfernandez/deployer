#!/bin/bash
set -euo pipefail

id="<% cli.id %>"
image="<% deployer.image %>:<% deployer.major %>.<% deployer.minor %>"

cp -r ../../../src/deployer ./

docker build -t ${image} .
docker tag ${image} ${image}.${id}
