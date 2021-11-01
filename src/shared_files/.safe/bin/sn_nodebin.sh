#!/bin/bash

root_dir=~/.safe/node/root_dir
if [ -d "$root_dir" ]; then
  log_file=$(ls -t1 $root_dir/sn_node.log* 2>/dev/null | head -n 1)
  if [[ $log_file != ""]]; then
    tac $log_file | sed -e '/ERROR/{N;N;q}' | tac | tb
  else
    echo -e "sn_node log not send\nMissing log file in directory $root_dir"
    exit
  fi
else
  echo -e "sn_node log not send\nMissing directory $root_dir"
  exit
fi
