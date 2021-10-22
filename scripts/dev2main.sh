#!/bin/bash

sed -i 's/dev/main/' ../src/shared_files/install_safe.sh
sed -i 's/dev/main/' ../src/joinnode-ipv4/Dockerfile
sed -i 's/dev/main/' ../src/joinnode-ipv6/Dockerfile
sed -i 's/dev/main/' ../src/rootnode-ipv4/Dockerfile
sed -i 's/dev/main/' ../src/rootnode-ipv6/Dockerfile
