#!/usr/bin/env bash

exitCode=0

if [ "${build}" == "" ];then
    build=0
fi

./hive do build devops deployer build ${build}
if [ $? == 1 ];then exitCode=1; fi

if [ ${exitCode} == 0 ];then
    docker run \
        --rm \
        --net=host \
        -v deployer_aws:/root/.aws \
        -v deployer_ssl:/root/ssl \
        deployer:0.0 $@
    if [ $? == 1 ];then exitCode=1; fi
fi

echo -e "\nExit code: ${exitCode}"
exit ${exitCode}
