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

# Install the safe network
curl -L $(curl --silent https://api.github.com/repos/maidsafe/safe_network/releases/latest | \
  jq --arg PLATFORM_ARCH "$PLATFORM_ARCH" \
  -r '.assets[] | select(.name | test("sn_cli.*"+$PLATFORM_ARCH+".tar.gz")).browser_download_url') | \
  tar xz -C ~/.safe/
curl -L $(curl --silent https://api.github.com/repos/maidsafe/safe_network/releases/latest | \
  jq --arg PLATFORM_ARCH "$PLATFORM_ARCH" \
  -r '.assets[] | select(.name | test("sn_node.*"+$PLATFORM_ARCH+".tar.gz")).browser_download_url') | \
  tar xz -C ~/.safe/node/

chmod a+x ~/.safe/safe
chmod a+x ~/.safe/node/sn_node

# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/latest/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/latest/shared_files/.bashrc -o ~/.bashrc

# Add bin files
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/sn_nodebin.sh -o ~/.safe/bin/sn_nodebin.sh
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/sn_networkbin.sh -o ~/.safe/bin/sn_networkbin.sh
