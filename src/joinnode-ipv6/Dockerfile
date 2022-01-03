# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.14
LABEL version="1.1"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2021-11-18"

# Update and install dependencies
RUN apk update && apk add \
    bash \
    curl \
    jq

RUN addgroup -g 1000 admin
RUN adduser -s /bin/bash --ingroup admin --uid 1000 --disabled-password admin
USER admin
WORKDIR /home/admin

# Install latest safe network version
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_install.sh -o /tmp/sn_install.sh
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_install_latest.sh -o /tmp/sn_install_latest.sh
RUN bash /tmp/sn_install_latest.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Adding a list of networks to join
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_add_networks.sh -o /tmp/sn_add_networks.sh
RUN bash /tmp/sn_add_networks.sh

# Default env values
ENV LOC_IP=[fe80::4e5:d0ff:fe82:a8d5]
ENV LOC_PORT=12000
ENV PUB_IP=[fe80::4e5::d0ff::fe82:a8d5]
ENV PUB_PORT=12000
ENV NETWORK_NAME="local-ipv6"

# Expose PORT of the node
EXPOSE $LOC_PORT

# Assign volume
VOLUME /home/admin/.safe/cli

# Launch safe join node
ENTRYPOINT safe networks switch $NETWORK_NAME \
  && RUST_LOG=safe_network=info,qp2p=info ~/.safe/node/sn_node \
  --skip-auto-port-forwarding
