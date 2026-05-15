#!/bin/bash

# grab global variables
source vars

LOCAL_IMAGE="localhost/${CONTAINER_NAME}"
DATE="$(date --utc '+%Y.%m.%d.%H%M%S'-local)"
TAG="${IMAGE_NAME}:${DATE}"

# Create manifest
buildah manifest create "${TAG}"

# Build and add for amd64
buildah bud --arch amd64 -t "${LOCAL_IMAGE}:${DATE}-amd64" .
buildah manifest add "${TAG}" "${LOCAL_IMAGE}:${DATE}-amd64"

# Build and add for arm64
buildah bud --arch arm64 -t "${LOCAL_IMAGE}:${DATE}-arm64" .
buildah manifest add "${TAG}" "${LOCAL_IMAGE}:${DATE}-arm64"

# Push manifest list (multi-arch image only)
buildah manifest push --all "${TAG}" "docker://${TAG}"
