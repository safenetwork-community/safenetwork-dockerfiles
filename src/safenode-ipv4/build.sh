#!/bin/bash

IMG_NAME=safe_node_img
CON_NAME=safe_node

sudo podman build --no-cache -t $IMG_NAME --build-arg TARGETPLATFORM=amd64 .
sudo podman run --name $CON_NAME -it $IMG_NAME
sudo podman stop $CON_NAME
sudo podman rm $CON_NAME
