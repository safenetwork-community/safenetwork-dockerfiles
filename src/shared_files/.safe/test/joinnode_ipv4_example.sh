#!/bin/bash

# `safe networks` for names

../bin/snc-node \
  --name comnet_local \
  --log-level "debug" \
  --skip-auto-port-forwarding true \
  --idle-timeout-msec 5500 \
  --keep-alive-interval-msec 4000 \
  --con-ip local_ipv4 \
  --con-port 12000 \
  --pub-ip local_ipv4 \
  --pub-port 12000 \
  --log-dir ~/.safe/node/sn_node_dir \
  --root-dir ~/.safe/node/sn_node_dir
