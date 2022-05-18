# Build SafeNetwork docker container
FROM docker.io/library/ubuntu:22.04
LABEL version="1.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-04-17"

ARG TARGETPLATFORM

# Update ubuntu package manager
RUN apt update
RUN apt upgrade -y

# Install ip networking application
RUN apt install -y iproute2

# Install download tools
RUN apt install -y curl jq

# Install progamming language compilers, build tools and package managers
RUN apt install -y build-essential
RUN apt install -y python3 python-is-python3 
RUN apt install -y python3-pip

# Install text editor
RUN apt install -y neovim

# Allow port 443 
RUN echo net.ipv4.ip_unprivileged_port_start=443 | tee -a /etc/sysctl.conf

# Install system setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/system_setup.sh -o /tmp/system_setup.sh
RUN bash /tmp/system_setup.sh

# Add admin user
RUN groupadd -g 1000 admin
RUN useradd -m -s /bin/bash --uid 1000 -g admin admin
USER admin
WORKDIR /home/admin

# Install user specific progamming language compilers
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- --default-toolchain none -y 

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Install user setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/user_setup.sh -o /tmp/user_setup.sh
RUN bash /tmp/user_setup.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.local/bin:/home/admin/.cargo/bin:/home/admin/.safe:/home/admin/.safe/node:/home/admin/.safe/bin

# Install user specific programming language core applications
RUN rustup default stable
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

# Download safe node run script
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/scripts/run_safenode.sh -o ~/.safe/bin/run_safenode.sh
RUN chmod a+x ~/.safe/bin/run_safenode.sh

# Launch safe node
ENTRYPOINT ~/.safe/bin/run_safenode.sh --name ${NETWORK_NAME} \
  --log-level ${LOG_LEVEL} \
  --num-node ${NUM_NODES} \
  --skip-auto-port-forwarding ${SKIP_AUTO_PORT_FORWARDING} \
  --idle-timeout-msec ${IDLE_TIMEOUT_MSEC} \
  --keep-alive-interval-msec ${KEEP_ALIVE_INTERVAL_MSEC} \
  --con-ip ${CON_IP} --con-port ${CON_PORT} \
  --pub-ip ${PUB_IP} --pub-port ${PUB_PORT} \
  --log-dir ${LOG_DIR} --root-dir ${ROOT_DIR} \
  --first ${FIRST}
