#!/bin/bash

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt-get update
sudo apt-get install azure-functions-core-tools-3
curl https://cdn.porter.sh/canary/install-linux.sh | bash
export PATH=~/.porter/:$PATH
porter mixins install jq --url https://github.com/squillace/porter-jq/releases/download --version v0.1.0
