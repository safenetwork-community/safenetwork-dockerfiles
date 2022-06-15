# Add addition safe directories
mkdir -p ~/.safe/{bin,test}

# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bashrc -o ~/.bashrc

# Add safe network bin files
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/snc-pb-node -o ~/.safe/bin/snc-pb-node
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/snc-pb-network -o ~/.safe/bin/snc-pb-network
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/bin/snc-node -o ~/.safe/bin/snc-node
chmod a+x ~/.safe/bin/*

# Add safe network test files
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/test/rootnode_example.sh -o ~/.safe/test/rootnode_example.sh
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.safe/test/joinnode_example.sh -o ~/.safe/test/joinnode_example.sh
chmod a+x ~/.safe/test/*

# Add nvim configuration files
mkdir -p ~/.config/nvim
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/init.lua -o ~/.config/nvim/init.lua
