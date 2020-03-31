#!/bin/bash

sudo apt-get -y install jq maven azure-functions-core-tools-3
curl https://cdn.porter.sh/canary/install-linux.sh | bash
export PATH=~/.porter/:$PATH
porter mixins install jq --url https://github.com/squillace/porter-jq/releases/download --version v0.1.0
