# Build SafeNetwork docker container
FROM docker.io/library/ubuntu:22.04
LABEL version="1.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-04-17"

ARG TARGETPLATFORM

# Update ubuntu package manager
RUN apt update
RUN apt upgrade -y

# Install download tools
RUN apt install -y curl jq

# Install progamming language compilers and package managers
RUN apt install -y build-essential
RUN apt install -y python3 python-is-python3
RUN apt install -y python3-pip

# Install text editor
RUN apt install -y neovim

# Install system setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/system_setup.sh -o /tmp/system_setup.sh
RUN bash /tmp/system_setup.sh

# Add admin user
RUN addgroup -g 1000 admin
RUN adduser -s /bin/bash --ingroup admin --uid 1000 --disabled-password admin
USER admin
WORKDIR /home/admin

# Install user specific progamming language compilers
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- --default-toolchain none -y 

# Install user setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/user_setup.sh -o /tmp/user_setup.sh
RUN bash /tmp/user_setup.sh

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.cargo/bin:/home/admin/.safe:/home/admin/.safe/node

# Install user specific programming language core applications
RUN rustup default stable
RUN pip install pbincli 

# Install safe network tools
RUN cargo install vdash
RUN cargo install sn_launch_tool

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
