# Build SafeNetwork Docker container
FROM alpine:3.14
LABEL version="0.1"
LABEL maintainer="Folât Pjêrsômêj"
LABEL release-date="2021-07-20"

# Update and install dependencies
RUN apk update && apk add \
    bash \
    curl \
    jq

COPY scripts/install_safe.sh /tmp/
RUN sh /tmp/install_safe.sh

# Set ENV PATH (after build will be used to find the safe node command)
ENV PATH=$PATH:/root/.safe

# Expose PORT of the node 
EXPOSE 12000

RUN safe node install
RUN safe node run-baby-fleming

# Launch safe on Docker command
CMD ["safe"]
