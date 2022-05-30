# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.15
LABEL version="1.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-04-17"

ARG TARGETPLATFORM

# Update Alpine package manager
RUN apk update

# Install better shell
RUN apk add bash

# Install download tools
RUN apk add curl jq

# Install progamming language compilers and package managers
RUN apk add build-base
RUN apk add python3
RUN apk add py3-pip
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then apk add rustup; fi
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then rustup-init -y; fi

# Install text editor
RUN apk add neovim

# Allow port 443 
RUN echo net.ipv4.ip_unprivileged_port_start=443 | tee -a /etc/sysctl.conf

# Install system setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/system_setup.sh -o /tmp/system_setup.sh
RUN bash /tmp/system_setup.sh

# Add admin user
RUN addgroup -g 1000 admin
RUN adduser -s /bin/bash --ingroup admin --uid 1000 --disabled-password admin
USER admin
WORKDIR /home/admin

# Install user specific progamming language compilers
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then rustup-init -y; fi

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Install user setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/user_setup.sh -o /tmp/user_setup.sh
RUN bash /tmp/user_setup.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.local/bin:/home/admin/.cargo/bin:/home/admin/.safe:/home/admin/.safe/node:/home/admin/.safe/bin

# Install user specific programming language core applications
RUN pip install pbincli 

# Install safe network tools
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7"]; then cargo install vdash; fi
RUN if [ "$TARGETFLATFORM" != "linux/arm/v7"]; then cargo install sn_launch_tool; fi

# Default env values
ENV NETWORK_NAME=
ENV LOG_LEVEL="error"
ENV NUM_NODES=1
ENV SKIP_AUTO_PORT_FORWARDING=true
ENV IDLE_TIMEOUT_MSEC=5500
ENV KEEP_ALIVE_INTERVAL_MSEC=4000
ENV CON_IP=10.88.0.2
ENV CON_PORT=12000
ENV PUB_IP=10.88.0.2
ENV PUB_PORT=12000
ENV LOG_DIR="/home/admin/.safe/node/node_dir_0"
ENV ROOT_DIR="/home/admin/.safe/node/node_dir_0"
ENV FIRST=false

# Expose PORT of the node
EXPOSE $CON_PORT

# Expose port of pastebin program
EXPOSE 443

# Assign volume
VOLUME /home/admin/.safe/cli

# Adding a list of networks to join
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/sn_add_networks.sh -o /tmp/sn_add_networks.sh
RUN bash /tmp/sn_add_networks.sh

# Launch safe node
ENTRYPOINT ~/.safe/bin/snc-node --name ${NETWORK_NAME} \
  --log-level ${LOG_LEVEL} \
  --num-nodes ${NUM_NODES} \
  --skip-auto-port-forwarding ${SKIP_AUTO_PORT_FORWARDING} \
  --idle-timeout-msec ${IDLE_TIMEOUT_MSEC} \
  --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC} \
  --con-ip ${CON_IP} --con-port ${CON_PORT} \
  --pub-ip ${PUB_IP} --pub-port ${PUB_PORT} \
  --log-dir ${LOG_DIR} --root-dir ${ROOT_DIR} \
  --first ${FIRST}
