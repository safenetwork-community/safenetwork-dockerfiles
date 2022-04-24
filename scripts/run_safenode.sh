#!/bin/bash

NETWORK_NAME=$1
VERBOSE=$2
CON_IP=$3
CON_PORT=$4
PUB_IP=$5
PUB_PORT=$6
IDLE_TIMEOUT_MSEC=$7
KEEP_ALIVE_INTERVAL_MSEC=$8
LOG_DIR=$9
ROOT_DIR=$10

if [ -z $NETWORK_NAME ] then
RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error sn_node ${VERBOSE} \
  --idle-timeout-msec ${IDLE_TIMEOUT_MSEC} \
  --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC} \
  --skip-auto-port-forwarding \
  --local-addr ${CON_IP}:${PUB_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --log-dir ${LOG_DIR} \
  --root-dir ${ROOT_DIR} \
  --first 
else
  safe networks switch ${NETWORK_NAME} \
  && RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error,qp2p=error sn_node \
  --idle-timeout-msec ${IDLE_TIMEOUT_MSEC} \
  --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC} \
  --skip-auto-port-forwarding \
  --local-addr ${CON_IP}:${PUB_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --log-dir ${LOG_DIR} \
  --root-dir ${ROOT_DIR}
fi
