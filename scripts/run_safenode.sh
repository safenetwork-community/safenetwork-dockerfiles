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

help()
{
  sn_node --help
}

version()
{
  echo "Podman run script for safenode v1.0"
  exit 2
}

usage()
{
  echo "Usage: run_safenode [ --name NETWORK_NAME ] 
    [ --verbose VERBOSE ]
    [ --num-nodes NUM_NODES ]
    [ --skip-auto-port-forwarding SKIP_AUTO_PORT_FORWARDING ]
    [ --idle-timeout-msec IDLE_TIMEOUT_MSEC ]
    [ --keep-alive-interval-msec KEEP_ALIVE_INTERVAL_MSEC ]
    [ --con-ip CON_IP ] 
    [ --con-port CON_PORT ]
    [ --pub-ip PUB_IP ]
    [ --pub-port PUB_PORT ]
    [ --log-dir LOG_DIR ]
    [ --root-dir ROOT_DIR ]
    [ --first FIRST ]"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -o $SHORT_OPTS --longoptions $LONG_OPTS --name $PROG_NAME -- "$@")

VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

eval set -- "$PARSED_ARGUMENTS"
while : 
do
  case "$1" in 
    --name) NETWORK_NAME="$2"; shift 2;;
    -v | --verbose) VERBOSE+=v; shift ;;
    --num-nodes) NUM_NODES="$2"; shift 2;;
    --skip-auto-port-forwarding) SKIP_AUTO_PORT_FORWARDING="$2"; shift 2;;
    --idle-timeout-msec) IDLE_TIMEOUT_MSEC="$2"; shift 2;;
    --keep-alive-interval-msec) KEEP_ALIVE_INTERVAL_MSEC="$2"; shift 2;;
    --con-ip) CON_IP="$2"; shift 2;;
    --con-port) CON_PORT="$2"; shift 2;;
    --pub-ip) PUB_IP="$2"; shift 2;;
    --pub-port) PUB_PORT="$2"; shift 2;;
    --log-dir) LOG_DIR="$2"; shift 2;;
    --root-dir) ROOT_DIR="$2"; shift 2;;
    --first) FIRST="$2"; shift 2;;
    -h | --help) help ;;
    -V | --version) version ;;
    --) shift; break ;;
    *) echo "Unexpected option: $1 - this should not happen."
       usage ;;
  esac
done

if [ -n "$VERBOSE" ]; then
  VERBOSE_OPT=" -${VERBOSE}"
fi

if [ "$SKIP_AUTO_PORT_FORWARDING" = true ]; then
  SKIP_AUTO_PORT_FORWARDING_OPT=" --skip-auto-port-forwarding"
fi

if [ "$IDLE_TIMEOUT_MSEC" = true ]; then
  IDLE_TIMEOUT_MSEC_OPT=" --idle-timeout-msec ${IDLE_TIMEOUT_MSEC}" 
fi

if [ "$KEEP_ALIVE_INTERVAL_MSEC" = true ]; then
  KEEP_ALIVE_INTERVAL_MSEC_OPT=" --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC}" 
fi

if [ -n "$LOG_DIR" ]; then
  LOG_DIR_OPT=" --log-dir ${LOG_DIR}" 
fi

if [ -n "$ROOT_DIR" ]; then
  ROOT_DIR_OPT=" --root-dir ${ROOT_DIR}" 
fi

if [ "$FIRST" = false ]; then
  safe networks switch ${NETWORK_NAME}
else
  FIRST_OPT=" --first"
fi 

CON_OPT=" --local-addr ${CON_IP}:${CON_PORT}"
PUB_OPT=" --public-addr ${PUB_IP}:${PUB_PORT}"

#RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error,qp2p=error sn_node\
#${VERBOSE_OPT}${IDLE_TIMEOUT_MSEC_OPT}${KEEP_ALIVE_INTERVAL_MSEC_OPT}${SKIP_AUTO_PORT_FORWARDING_OPT}\
#${CON_OPT}${PUB_OPT}${LOG_DIR_OPT}${ROOT_DIR_OPT}${FIRST_OPT}

for (( i = 1; i <= NUM_NODES; i++ ))
  do
  CON_PORT=$(($CON_PORT + $i))
  PUB_PORT=$(($PUB_PORT + $i))

#echo RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error,qp2p=error sn_node\
#${VERBOSE_OPT}${IDLE_TIMEOUT_MSEC_OPT}${KEEP_ALIVE_INTERVAL_MSEC_OPT}${SKIP_AUTO_PORT_FORWARDING_OPT}\
#${CON_OPT}${PUB_OPT}${LOG_DIR_OPT}${ROOT_DIR_OPT}

  RUST_BACKTRACE=full COLORBT_SHOW_HIDDEN=1 RUST_LOG=safe_network=error,qp2p=error sn_node\
${VERBOSE_OPT}${IDLE_TIMEOUT_MSEC_OPT}${KEEP_ALIVE_INTERVAL_MSEC_OPT}${SKIP_AUTO_PORT_FORWARDING_OPT}\
${CON_OPT}${PUB_OPT}${LOG_DIR_OPT}${ROOT_DIR_OPT}

  done

if [ "$FIRST" = true ]; then 
  safe networks add ${NETWORK_NAME}
  safe networks switch ${NETWORK_NAME}
fi 


