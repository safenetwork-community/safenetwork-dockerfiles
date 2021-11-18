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

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/sn_install.sh -o /tmp/sn_install.sh
RUN bash /tmp/sn_install.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Default env values
ENV ROOTNODE_IP=127.0.0.1
ENV ROOTNODE_PORT=12000

# Expose PORT of the node
EXPOSE $ROOTNODE_PORT

# Assign volume
VOLUME /home/admin/.safe/cli

# Launch safe root node
ENTRYPOINT sn_node -vv --idle-timeout-msec 5500 --keep-alive-interval-msec 4000 --skip-igd --local-addr $ROOTNODE_IP:$ROOTNODE_PORT --first
