#!/bin/bash

conn_file=~/.safe/node/node_connection_info.config
if [ -f "$conn_file"]; then
  cat $conn_file | tb
else
  echo -e "node_connection_info.config file does not exist."
fi
