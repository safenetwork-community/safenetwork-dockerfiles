#!/bin/bash

# `safe networks` for names

../bin/snc-node \
  --name comnet_local \
  --log-level "debug" \
  --skip-auto-port-forwarding true \
  --idle-timeout-msec 5500 \
  --keep-alive-interval-msec 4000 \
  --con-ip local_ipv6 \
  --con-port 12000 \
  --pub-ip local_ipv6 \
  --pub-port 12000 \
  --log-dir /var/logs/safenode \
  --root-dir ~/.safe/node/safenode
