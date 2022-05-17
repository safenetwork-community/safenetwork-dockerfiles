#!/bin/bash

# Create test folder
mkdir -p ~/.safe/test

# Download test files
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/test/rootnode_example.sh -o ~/.safe/test/rootnode_example.sh
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/test/joinnode_example.sh -o ~/.safe/test/joinnode_example.sh
chmod a+x ~/.safe/bin/*


