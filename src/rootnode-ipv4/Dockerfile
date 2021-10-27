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

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/install_safe.sh -o /tmp/install_safe.sh
RUN bash /tmp/install_safe.sh

# Install wrapper script
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/scripts/install_safe.sh -o ~/.safe/run-rootnode-ipv4.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:~/.safe:~/.safe/node

# Expose PORT of the node
EXPOSE 12000

# Launch safe root nodes 
ENTRYPOINT ["~/.safe/run-rootnode-ipv4.sh"]
