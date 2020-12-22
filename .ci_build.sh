#!/bin/bash
set -xe

sudo apt-get install -y gcc-arm-none-eabi binutils-arm-none-eabi

# Would be nice to clone the repo with submodules. If you know how to do this, please make a PR!
git submodule update --init --recursive

make -j clean
make -j
