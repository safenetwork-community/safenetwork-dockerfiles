# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.15
LABEL version="1.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2022-03-04"

ARG TARGETPLATFORM

# Update Alpine package manager
RUN apk update

# Install download dependencies
RUN apk add bash curl jq

# Install text editor
RUN apk add neovim

# Install progamming language for bin scripts
RUN apk add python3

# Install system setup
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/system_setup.sh -o /tmp/system_setup.sh
RUN bash /tmp/system_setup.sh

RUN addgroup -g 1000 admin
RUN adduser -s /bin/bash --ingroup admin --uid 1000 --disabled-password admin
USER admin
WORKDIR /home/admin

# Install latest safe network version
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Adding a list of networks to join
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/latest/scripts/sn_add_networks.sh -o /tmp/sn_add_networks.sh
RUN bash /tmp/sn_add_networks.sh

# Default env values
ENV CON_IP=10.0.2.100
ENV CON_PORT=12000
ENV PUB_IP=10.0.2.100
ENV PUB_PORT=12000
ENV NETWORK_NAME="local-ipv4"

# Expose PORT of the node
EXPOSE $CON_PORT

# Assign volume
VOLUME /home/admin/.safe/cli

# Launch safe join node
ENTRYPOINT safe networks switch $NETWORK_NAME \
  && RUST_LOG=safe_network=info,qp2p=info ~/.safe/node/sn_node \
  --skip-auto-port-forwarding
