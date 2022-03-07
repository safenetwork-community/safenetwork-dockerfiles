# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.15
LABEL version="1.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-03-04"

ARG TARGETPLATFORM

# Update Alpine package manager
RUN apk update

# Install better shell
RUN apk add bash

# Install download tools
RUN apk add curl jq

# Install progamming languages and it's package managers
RUN apk add python3
RUN apk add py3-pip
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then apk add build-base; fi
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then apk add rustup; fi
RUN if [ "$TARGETPLATFORM" != "linux/arm/v7" ]; then rustup-init -y; fi

# Install text editor
RUN apk add neovim

# Install pastebin CLI
RUN pip install pbincli 

# Install system setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/system_setup.sh -o /tmp/system_setup.sh
RUN bash /tmp/system_setup.sh

RUN addgroup -g 1000 admin
RUN adduser -s /bin/bash --ingroup admin --uid 1000 --disabled-password admin
USER admin
WORKDIR /home/admin

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Default env values
ENV CON_IP=[fe80::4e5:d0ff:fe82:a8d5]
ENV CON_PORT=12000
ENV PUB_IP=[fe80::4e5:d0ff:fe82:a8d5]
ENV PUB_PORT=12000

# Expose PORT of the node
EXPOSE $CON_PORT

# Assign volume
VOLUME /home/admin/.safe/cli

# Launch safe root node
ENTRYPOINT sn_node -vv \
  --idle-timeout-msec 5500 \
  --keep-alive-interval-msec 4000 \
  --skip-auto-forwarding \
  --local-addr ${CON_IP}:${CON_PORT} \
  --public-addr ${PUB_IP}:${PUB_PORT} \
  --first
