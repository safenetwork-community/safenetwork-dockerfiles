#!/bin/bash

while getopts 'n:v:a:b:c:d:f:l:r:s:' c
do
  case $c in 
    n | name) NETWORK_NAME=$OPTARG;;
    v | verbose) VERBOSE=$OPTARG;;
    a | con_ip) CON_IP=$OPTARG;;
    b | con_port) CON_PORT=$OPTARG;;
    c | pub_ip) PUB_IP=$OPTARG;;
    d | pub_port) PUB_PORT=$OPTARG;;
    f | first) FIRST=$OPTARG;;
    i | idle_timeout_msec) IDLE_TIMEOUT_MSEC=$OPTARG;;
    k | keep_alive_interval_msec) KEEP_ALIVE_INTERVAL_MSEC=$OPTARG;;
    l | log_dir) LOG_DIR=$OPTARG;;
    r | root_dir) ROOT_DIR=$OPTARG;;
    s | skip-auto-port-forwarding) SKIP_AUTO_PORT_FOWARDING=$OPTARG;;
  esac
done

RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error,qp2p=error sn_node ${VERBOSE} \
  --idle-timeout-msec ${IDLE_TIMEOUT_MSEC} \
  --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC} \
  if [ $SKIP_AUTO_PORT_FOWARDING = true ]; then --skip-auto-port-forwarding; fi \
  --local-addr ${CON_IP}:${PUB_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --log-dir ${LOG_DIR} \
  --root-dir ${ROOT_DIR} \
  if [ $FIRST = true ]; then --first; fi
