#!/usr/bin/env bash

# SETUP SECRETS
echo "Please enter your AWS Access Key Id:"
read access_key
echo "Please enter your AWS Secret Access Key:"
read secret_key

secrets_file="./.secrets/.secrets.sh"
echo \#!/usr/bin/env bash > ${secrets_file}
echo aws_access_key_id=\"${access_key}\" >> ${secrets_file}
echo aws_secret_access_key=\"${secret_key}\" >> ${secrets_file}

cd ./.secrets
./setup_secrets.sh
cd ..

# RUN A FIRST BUILD
./test.sh
