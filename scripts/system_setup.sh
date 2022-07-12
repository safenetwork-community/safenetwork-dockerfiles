#!/bin/bash

# Safe network node log directory
install -d -o root -g admin -m 750 /var/log/sn_node

# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bashrc -o ~/.bashrc

# Nvim support files
mkdir -p ~/.config/nvim
mkdir -p /usr/local/share/lua/5.1
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/init.lua -o ~/.config/nvim/init.lua
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/lua/keymappings.lua -o /usr/local/share/lua/5.1/keymappings.lua
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/lua/keymappings.lua -o /usr/share/lua/5.1/keymappings.lua
