#!/bin/bash

../run_safenode.sh 
  --name join_test \
  --verbose -vv \
  --skip-auto-port-forwarding true \
  --idle-timeout-msec 5500 \
  --keep-alive-interval-msec 4000 \
  --con-ip 10.88.0.2 \
  --con-port 12000 \
  --pub-ip 195.240.113.178 \
  --pub-port 12000 \
  --log-dir ~/.safe/node/node_dir_0\
  --root-dir ~/.safe/node/node_dir_0\
