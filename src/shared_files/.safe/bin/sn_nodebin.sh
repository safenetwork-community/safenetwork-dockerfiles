#!/bin/bash

tac $(ls -t1 ~/.safe/node/root_dir/sn_node.log.* | head -n 1) \
  | sed -e '/ERROR/{N;N;q}' | tac | tb
