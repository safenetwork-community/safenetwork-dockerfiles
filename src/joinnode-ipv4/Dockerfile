# Build SafeNetwork docker container
FROM docker.io/library/alpine:3.14
LABEL version="1.0"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2021-11-12"

# Update and install dependencies
RUN apk update && apk add \
    bash \
    curl \
    jq

RUN adduser -s /bin/bash --disabled-password admin
USER admin
WORKDIR /home/admin

# Install latest safe network version
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_install.sh -o /tmp/sn_install.sh
RUN bash /tmp/sn_install.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Adding a list of networks to join
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_add_networks.sh -o /tmp/sn_add_networks.sh
RUN bash /tmp/sn_add_networks.sh

# Default env values
ENV JOINNODE_IP=127.0.0.1
ENV NETWORK_NAME="local-ipv4"

# Expose PORT of the node
EXPOSE $JOINNODE_PORT

# Launch safe join node
ENTRYPOINT safe network switch $NETWORK_NAME && RUST_LOG=safe_network=info,qp2p=info ~/.safe/node/sn_node --skip-igd
