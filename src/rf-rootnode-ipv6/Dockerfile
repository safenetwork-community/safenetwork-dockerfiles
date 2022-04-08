# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.15
LABEL version="1.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-03-04"

ARG TARGETPLATFORM

# Set user
USER root
WORKDIR /root

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

# Install pastebin CLI
RUN pip install pbincli 

# Install system setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/system_setup.sh -o /tmp/system_setup.sh
RUN bash /tmp/system_setup.sh

# Install user setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/user_setup.sh -o /tmp/user_setup.sh
RUN bash /tmp/user_setup.sh

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/root/.cargo/bin:/root/.safe:/root/.safe/node:/root/.safe/bin

# Install safe network tools
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then cargo install vdash; fi
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then cargo install sn_launch_tool; fi

# Default env values
ENV CON_IP=[fe80::4e5:d0ff:fe82:a8d5]
ENV CON_PORT=12000
ENV PUB_IP=[fe80::4e5:d0ff:fe82:a8d5]
ENV PUB_PORT=12000
ENV VERBOSE="-v"

# Expose PORT of the node
EXPOSE $CON_PORT

# Assign volume
VOLUME /root/.safe/cli

# Launch safe root node
ENTRYPOINT RUST_LOG=safe_network=trace sn_node ${VERBOSE} \
  --idle-timeout-msec 5500 \
  --keep-alive-interval-msec 4000 \
  --skip-auto-port-forwarding \
  --local-addr ${CON_IP}:${CON_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --log-dir /root/.safe/node/node_dir_0 \
  --root-dir /root/.safe/node/node_dir_0 \
  --first
