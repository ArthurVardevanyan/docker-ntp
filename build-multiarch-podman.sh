#!/bin/bash

# grab global variables
source vars

DATE="$(date --utc '+%Y.%m.%d.%H%M%S'-local)"
TAG="${IMAGE_NAME}:${DATE}"

podman manifest create "${TAG}"

podman build --platform linux/amd64,linux/arm64 -f Dockerfile --manifest "${TAG}"

podman manifest push "${TAG}"