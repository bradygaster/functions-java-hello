#!/bin/bash

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
apt-get update
apt-get install azure-functions-core-tools-3
curl https://cdn.porter.sh/canary/install-linux.sh | bash
export PATH=~/.porter/:$PATH
porter mixins install jq --url https://github.com/squillace/porter-jq/releases/download --version v0.1.0
