# Build SafeNetwork docker container
FROM alpine:3.14
LABEL version="0.3"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2021-10-22"

# Update and install dependencies
RUN apk update && apk add \
    bash \
    curl \
    jq

RUN adduser -s /bin/bash --disabled-password admin
USER admin
WORKDIR /home/admin

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/install_safe.sh -o /tmp/install_safe.sh
RUN bash /tmp/install_safe.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/home/admin/.safe:/home/admin/.safe/node

# Expose PORT of the node
EXPOSE 12000

# Launch safe root node
ENTRYPOINT ["sn_node", "-vv", "--idle-timeout-msec", "5500", "--keep-alive-interval-msec", "4000", "--skip-igd", "--local-addr", "127.0.0.0:1", "--first"]
