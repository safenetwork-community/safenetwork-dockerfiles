#!/bin/bash

PLATFORM_ARCH=`uname -m`

case "$PLATFORM_ARCH" in
  "armv7l")
  PLATFORM_ARCH="armv7-unknown-linux-musleabihf"
  ;;
  "armv6l")
  PLATFORM_ARCH="arm-unknown-linux-musleabi"
  ;;
  *)
  PLATFORM_ARCH=$PLATFORM_ARCH"-unknown-linux-musl"
  ;;
esac

# Create safe folders
mkdir -p ~/.safe/{bin,cli,node}

# Install the safe network command line interface
curl -L $(curl --silent https://api.github.com/repos/maidsafe/sn_cli/releases/latest | \
  jq --arg PLATFORM_ARCH "$PLATFORM_ARCH" \
  -r '.assets[] | select(.name | endswith($PLATFORM_ARCH+".tar.gz")).browser_download_url') | \
  tar xz -C ~/.safe/

# Install the safe network node
curl -L --silent https://github.com/maidsafe/safe_network/releases/download/v0.32.0/sn_node-0.32.0-aarch64-unknown-linux-musl.tar.gz | \
  tar xz -C ~/.safe/node

# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.bashrc -o ~/.bashrc

# Add sn_nodebin.sh
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/.safe/bin/sn_nodebin.sh -o ~/.safe/bin/sn_nodebin.sh



