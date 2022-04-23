#!/bin/bash

CON_NAME=safe_node

sudo podman build -t $CON_NAME --build-arg TARGETPLATFORM=amd64 .
sudo podman run -it $CON_NAME
sudo podman stop $CON_NAME
sudo podman rm -f $CON_NAME
