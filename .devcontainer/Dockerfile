#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=root
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# [Optional] Version of Node.js to install.
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
ENV NVM_DIR=/home/vscode/.nvm

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update
RUN apt-get -y install --no-install-recommends apt-utils dialog 2>&1
    
# Verify git, process tools, lsb-release (common in install instructions for CLIs) installed
RUN apt-get -y install git iproute2 procps apt-transport-https gnupg2 curl lsb-release

# Install the Azure CLI
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/azure-cli.list
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | apt-key add - 2>/dev/null
RUN apt-get update 
RUN apt-get install -y azure-cli;
# RUN porter mixins install jq --url https://github.com/squillace/porter-jq/releases/download --version v0.1.0

# Install the scenario prerequisities
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
RUN curl https://cdn.porter.sh/canary/install-linux.sh | bash
RUN apt-get -y install azure-functions-core-tools-3

    #
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.
    # && groupadd --gid $USER_GID $USERNAME \
    # && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for the non-root user
    # && apt-get install -y sudo \
    # && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    # && chmod 0440 /etc/sudoers.d/$USERNAME \
    
# Clean up
RUN apt-get autoremove -y \
&& apt-get clean -y \
&& rm -rf /var/lib/apt/lists/* \
&& export PATH=~/.porter/:$PATH \

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
