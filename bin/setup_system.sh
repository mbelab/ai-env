#!/usr/bin/env bash

# Setup system script (sudo)
# mbelab


# script
sudo -v

option="$1"

# update package index
sudo apt-get update

# install base packages
sudo apt-get install -y gcc g++ gdb make cmake pkgconf jq wget

# install base python packages
sudo apt-get install -y python3 python3-venv python3-pip

# install OpenSSL packages
sudo apt-get install -y libssl-dev

# install OpenBLAS packages
sudo apt-get install -y libopenblas-dev

# install Vulkan packages depending on option
if [[ $option = '--vulkan' ]]
then
    sudo apt-get install -y libvulkan-dev glslc spirv-headers
fi
