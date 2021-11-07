#!/bin/sh

sn_node -vv --idle-timeout-msec 5500 --keep-alive-interval-msec 4000 --skip-igd --local-addr $1 --first
