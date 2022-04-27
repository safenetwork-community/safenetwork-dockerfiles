#!/bin/bash

./run_safenode.sh \
  --name test \ 
  --verbose -vv \
  --idle-timeout-msec=5500 \
  --keep-alive-interval-msec=4000 \
  --con-ip=10.88.0.2 \
  --con-port=12000 \
  --pub-ip=195.240.113.178 \
  --pub-port=12000 \
  --log-dir= \
  --root-dir= \
  --first=true