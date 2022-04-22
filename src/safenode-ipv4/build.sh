#!/bin/bash

podman build . --build-arg TARGETPLATFORM=amd64
# podman run -it . /bin/bash
