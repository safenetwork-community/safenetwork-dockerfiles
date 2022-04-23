# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bashrc -o ~/.bashrc

# Add safe network bin files
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/pb_nodes.sh -o ~/.safe/bin/pb_nodes.sh
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/pb_network.sh -o ~/.safe/bin/pb_network.sh
chmod a+x ~/.safe/bin/*

# Add nvim configuration files
mkdir -p ~/.config/nvim
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/init.lua -o ~/.config/nvim/init.lua
