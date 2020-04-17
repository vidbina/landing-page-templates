FIREFOX := firefox

FIREFOX_PATH := ./.firefox

# Laptop with HiDPI 1440w×900h
SCREENSHOT_HIDPI_WIDTH := 1440
SCREENSHOT_HIDPI_HEIGHT := 900

# iPhone 6/7/8 375w×667h
SCREENSHOT_IPHONE7_WIDTH := 375
SCREENSHOT_IPHONE7_HEIGHT := 667

%/preview-desktop.png:
	mkdir -p ${FIREFOX_PATH}
	${FIREFOX} \
		--profile `realpath ${FIREFOX_PATH}/` \
		--new-instance \
		--screenshot $@ \
		--window-size=${SCREENSHOT_HIDPI_WIDTH},${SCREENSHOT_HIDPI_HEIGHT} \
		http://localhost/$(@D)

%/preview-mobile.png:
	${FIREFOX} --screenshot $@ http://localhost/$(@D) --window-size=375,667

# Examples of chrome screenshot commands:
#   chrome --headless --disable-gpu --screenshot --window-size=412,732 https://www.chromestatus.com/
#   google-chrome --headless --hide-scrollbars --remote-debugging-port=9222 --disable-gpu
# The following args have been provided default values but can be overriden
# from the CLI by specifying those variables with the override values or by
# declaring those variables in the project.mk file which is conditionally
# included after variable declaration in this Makefile.

# <<<<<<<<<<<<<<<<<<<<<<<

# Path to the shippable part of your application
# The shippable part of your application should contain manifest files
# (requirements.txt in case of pip, pyproject.toml and poetry.lock in case of
# Poetry) and the actual source that you will want to run inside of your
# container.
APP_PATH ?= .

# Version of the application to build
APP_VERSION ?= 0.1.0

# Name of the application and resulting Docker image
APP_NAME ?= landing-page-templates

# Ports of the application to expose
APP_PORTS ?= 8000/tcp

# Version for the base Node.js Docker image
# The notation of the version should match the semver notation for which there
# are official Docker images available, otherwise the BASE_IMAGE variable will
# have to be modified to pull the appropriate Docker base image.
NODEJS_VERSION ?= 13.13.0

# Docker image registry
DOCKER_IMAGE_REGISTRY ?= index.docker.io/

# Base image (as FROM) for all project images
# Try to use official images as much as possible.
# https://docs.docker.com/docker-hub/official_images/
DOCKER_NODEJS_IMAGE ?= ${DOCKER_IMAGE_REGISTRY}node:${NODEJS_VERSION}-stretch-slim

# Node.js dependency installation command
# The following example installation commands should work:
# -	for projects that use NPM: `npm install`
# - for projects that use Yarn: `yarn install`
NODEJS_PACKAGE_INSTALL_COMMAND ?= npm install

# Host address for port mapping
# Don't use 0.0.0.0 as this opens up your machine,
HOST_ADDRESS ?= 127.0.0.1

# Version to use for tagging images
# By default the APP_VERSION and NODEJS_VERSION are factored into the VERSION
# variable such that NODEJS_VERSION is part of the pre-release clause. The
# reason the build metadata was not utilized in this case is because Docker
# does not allow for tags containing build metadata clauses since plus-signs
# (+) are technically not allowed in Docker tags.
# https://semver.org/
VERSION ?= ${APP_VERSION}-nodejs-${NODEJS_VERSION}


# Docker container parameters

# Docker image to use as a source for development and production images
DOCKER_CONTAINER_BASE_IMAGE = ${DOCKER_NODEJS_IMAGE}

# Home path of the container in order to adequately mount .homedir
DOCKER_CONTAINER_HOME_PATH = /home/developer

# Ports of the container to expose
DOCKER_CONTAINER_PORTS = ${APP_PORTS}


# Docker host parameters

# IP address or hostname of the host, defaults to the host loopback address
DOCKER_HOST_ADDRESS = ${HOST_ADDRESS}

# Path of the project of interest, defaults to the current working directory
DOCKER_HOST_PROJECT_PATH = ${PWD}


# Docker image name
DOCKER_IMAGE_NAME = ${APP_NAME}

# Docker image tag
DOCKER_IMAGE_TAG = ${VERSION}

# Absolute path to Dockerfile
DOCKER_FILE = ${PWD}/Dockerfile

# Caching flag for Docker build process
# Disable caching to force the docker builder to always rebuild all layers and
# thus minimize the chances of cached layers providing a false sense of build
# validity. If a build is broken because some resource is no longer available
# from the registries, you would need to know this as soon as possible i.e.:
# before hitting production environments.
DOCKER_CACHE_FLAG ?= "--no-cache"

# Arguments for Docker image builds
# - DOCKER_BASE_IMAGE defines the Docker image to use in the FROM instruction
# - DOCKER_PORTS defines the ports to expose on the production image
# - PROJECT defines the name of the project and name of the subdirectory of
#   /opt where to install the project
# - NODEJS_PACKAGE_INSTALL_COMMAND defines the command to install Node.js
#   packages
DOCKER_BUILD_ARGS = \
	--build-arg=DOCKER_BASE_IMAGE="${DOCKER_CONTAINER_BASE_IMAGE}" \
	--build-arg=DOCKER_PORTS="${DOCKER_CONTAINER_PORTS}" \
	--build-arg=PROJECT="${PROJECT}" \
	--build-arg=NODEJS_PACKAGE_INSTALL_COMMAND="${NODEJS_PACKAGE_INSTALL_COMMAND}" \

# Define the command line arguments to use in spawning Docker runs.
# - Defines environment variables (-e)
# - Defines port mappings (-p)
# - Sets the UID and GID to those of the host user (-u)
#   Ensures sensible ownership defaults on Linux hosts
# - Mounts volumes (-v)
# - Sets working directory (-w)
DOCKER_ARGS = \
	-e "PROJECT=${PROJECT}" \
	-e "HOME=${DOCKER_CONTAINER_HOME_PATH}" \
	-u `id -u`:`id -g` \
	-v ${DOCKER_HOST_PROJECT_PATH}/.homedir:${DOCKER_CONTAINER_HOME_PATH} \
	-v `realpath ${APP_PATH}`:/tmp/${PROJECT} \
	-w /tmp/${PROJECT}


# Include the project.mk file if it exists to override defined parameters
-include project.mk

# Remove temporary files
clean:
	@rm -rf .node-modules

# Spawn a Bash shell for the development image
bash:
	@mkdir -p ${DOCKER_HOST_PROJECT_PATH}/.homedir
	@docker run \
		${DOCKER_ARGS} \
		--rm -it \
		${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}-dev bash

# Build production image
prod-image:
	@docker build \
		${DOCKER_CACHE_FLAG} \
		${DOCKER_BUILD_ARGS} \
		--file=${DOCKER_FILE} \
		--rm \
		--tag="${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}" \
		--target=prod-image \
		${APP_PATH}

# Build development image
dev-image:
	@docker build \
		${DOCKER_CACHE_FLAG} \
		${DOCKER_BUILD_ARGS} \
		--file=${DOCKER_FILE} \
		--rm \
		--tag="${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}-dev" \
		--target=dev-image \
		${APP_PATH}

.PHONY: prod-image dev-image bash clean
