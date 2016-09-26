#!/usr/bin/env bash
. ./.secrets.sh

deployer_aws="deployer_aws"

# SETUP AWS CREDENTIALS IN A VOLUME
docker volume rm ${deployer_aws} > /dev/null
credential_path="/test"
credential_file="${credential_path}/credentials"
cmd="echo [default] > ${credential_file}; "
cmd+="echo aws_access_key_id = ${aws_access_key_id}  >> ${credential_file}; "
cmd+="echo aws_secret_access_key = ${aws_secret_access_key} >> ${credential_file}"
cmd+=""
docker run --rm -v ${deployer_aws}:${credential_path} busybox //bin/sh -c "${cmd}"
