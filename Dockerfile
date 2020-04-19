# The Docker "context" is the working directory for Docker which, for this
# setup, is set to the value of the APP_PATH variable in the Makefile. In case
# of a misconfiguration where the needed files are not found at the root of the
# APP_PATH directory, COPY commands are expected to fail. The files of interest
# within the Docker context are the Node.js package manifests, which are
# package.json files when using NPM or Yarn as package managers.

# Do not provide a default base image in order to make this choice explicit
ARG DOCKER_BASE_IMAGE


FROM ${DOCKER_BASE_IMAGE} AS dev-image

# Copy install-deps.sh for project-specified installation commands
COPY ./install-deps.sh /tmp/install-deps.sh

# Install system dependencies and run project-specified installation commands
# Note that there are no packages installed by default
RUN apt-get update && apt-get install -y --no-install-recommends \
    && . /tmp/install-deps.sh \
    && rm -rf /var/lib/apt/lists/*

ARG PROJECT=app
ENV PROJECT=${PROJECT}
WORKDIR /tmp/${PROJECT}

# Copy Node.js package manifests and install Node.js packages
ARG NODEJS_PACKAGE_INSTALL_COMMAND="npm install"
COPY . /tmp/${PROJECT}/
RUN ${NODEJS_PACKAGE_INSTALL_COMMAND}


FROM ${DOCKER_BASE_IMAGE} AS prod-image

USER node

COPY --from=dev-image /usr/lib /usr/lib

ARG PROJECT=app
ENV PROJECT=${PROJECT}
WORKDIR /opt/${PROJECT}

# Explicitly listing all files to be copied as opposed to listing non-wanted
# files in a .dockerignore file makes it easier to examine (e.g.: during
# code-reviews) which files will be shipped with builds. Relying on
# .dockerignore as the primary means to manage the assets for build images is
# arguably less secure as it doesn't explicitly require approval or listing of
# assets prior to them finding their way into a shipped image.
# As a rule of thumb, use the .dockerignore file to reduce the build context
# and avoid using it as the primary means to keep files from ending up in
# images mean for deployment.
# Prefer COPY over ADD
# Copy Node.js package manifests and install Node.js packages
ARG NODEJS_PACKAGE_INSTALL_COMMAND="npm install"
COPY --chown=node . /opt/${PROJECT}/
RUN ${NODEJS_PACKAGE_INSTALL_COMMAND}

# Do not provide default ports in order to make this choice explicit
ARG DOCKER_PORTS

# Expose the ports for the services
EXPOSE ${DOCKER_PORTS}
