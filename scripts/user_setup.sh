# Add .bashrc and .bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bash_profile -o ~/.bash_profile
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.bashrc -o ~/.bashrc

# Add nvim configuration files
mkdir -p ~/.config/nvim
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/nvim.lua -o ~/.config/nvim/nvim.lua
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/src/shared_files/.config/nvim/keymappings.lua -o ~/.config/nvim/keymappings.lua