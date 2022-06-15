#!/bin/bash

# Safe network node log directory
install -d -o root -g admin -m 750 /var/log/sn_node

# Nvim support files
mkdir -p /usr/local/share/lua/5.1
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/lua/keymappings.lua -o /usr/local/share/lua/5.1/keymappings.lua


