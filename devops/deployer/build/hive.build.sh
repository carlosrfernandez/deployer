#!/bin/bash
set -euo pipefail

build="<% cli.build %>"
image="<% docker.image %>:<% version.major %>.<% version.minor %>"

rm -r deployer
cp -r ../../../src/deployer ./

docker build -t ${image} .
docker tag ${image} ${image}.${build}
