#!/bin/bash

PROG_NAME=run_safenode

SHORT_OPTS=hVv
LONG_OPTS="name:,verbose:,num-nodes:,\
skip-auto-port-forwarding:,\
con-ip:,con-port:,pub-ip:,pub-port:,\
idle-timeout-msec:,keep-alive-interval-msec:,\
log-dir:,root-dir:,first:,version,help"

IDLE_TIMEOUT_MSEC=4000
KEEP_ALIVE_INTERVAL_MSEC=5500

echo "Parameters: $@"


