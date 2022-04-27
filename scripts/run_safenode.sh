#!/bin/bash

usage()
{
  echo "Usage: run_safenode [ -n | --name NETWORK_NAME ] 
    [ -v | -vv | -vvv | -vvvv ]
    [ -a | --con-ip CON_IP ] 
    [ -b | --con-port CON_PORT ]"
  exit 2
}

PARSED_ARGUMENTS=$(
  getopt -a -n run_safenode \
    --long name,verbose,con-ip,con-port,pub-ip,pub-port,first,\
    idle-timeout-msec,keep-alive-interval-msec,log-dir,root-dir,\
    skip-auto-port-forwarding: -- "$@")

VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while : 
do
  case "$1" in 
    --name) NETWORK_NAME="$2"; shift 2;;
    --verbose) VERBOSE="$2"; shift 2;;
    --skip-auto-port-forwarding) SKIP_AUTO_PORT_FOWARDING="$2"; shift 2;;
    --idle-timeout-msec) IDLE_TIMEOUT_MSEC="$2"; shift 2;;
    --keep-alive-interval-msec) KEEP_ALIVE_INTERVAL_MSEC="$2"; shift 2;;
    --con-ip) CON_IP="$2"; shift 2;;
    --con-port) CON_PORT="$2"; shift 2;;
    --pub-ip) PUB_IP="$2"; shift 2;;
    --pub-port) PUB_PORT="$2"; shift 2;;
    --log-dir) LOG_DIR="$2"; shift 2;;
    --root-dir) ROOT_DIR="$2"; shift 2;;
    --first) FIRST="$2"; shift 2;;
    --) shift; break ;;
    *) echo "Unexpected option: $1 - this should not happen."
       usage ;;
  esac
done

if [ "$FIRST" = false ]; then
  safe networks switch ${NETWORK_NAME}
else
  FIRST_C=--first
fi 

if [ "$SKIP_AUTO_PORT_FOWARDING" = true ]; then
  $SKIP_AUTO_PORT_FOWARDING_C=--skip-auto-port-forwarding
fi

RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error,qp2p=error sn_node ${VERBOSE} \
  --idle-timeout-msec ${IDLE_TIMEOUT_MSEC} \
  --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC} \
  ${SKIP_AUTO_PORT_FOWARDING_C} \
  --local-addr ${CON_IP}:${PUB_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --log-dir ${LOG_DIR} \
  --root-dir ${ROOT_DIR} \
  ${FIRST_C}

if [ "$FIRST" = true ]; then 
  safe networks add ${NETWORK_NAME}
  safe networks switch ${NETWORK_NAME}
fi 


