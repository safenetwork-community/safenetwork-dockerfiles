# Build SafeNetwork docker container
FROM alpine:3.14
LABEL version="0.2"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2021-10-17"

# Update and install dependencies
RUN apk update && apk add \
    bash \
    curl \
    jq

# Install latest safe network version.
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/main/src/shared_files/install_safe.sh -o /tmp/install_safe.sh
RUN sh /tmp/install_safe.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/root/.safe

# Expose PORT of the node 
EXPOSE 12000

# Install safe node plugin
RUN safe node install

# Launch safe on Docker command
ENTRYPOINT ["safe"]
