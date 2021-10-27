#!/bin/bash

# Start the genesis node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 --first \ 
  --root_dir sn-node-genesis

# Start the second node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-2

# Start the third node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-3

# Start the fourth node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-4

# Start the fifth node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-5

# Start the sixth node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-6

# Start the seventh node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-7

# Start the eighth node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-8

# Start the ninth node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-9

# Start the tenth node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-10

# Start the eleventh node
sn_node -vv --idle-timout-msec 5500 --keep-alive-interval-mesc 4000 --skip-igd --local-addr 127.0.0.0:1 \
  --root_dir sn-node-11

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
