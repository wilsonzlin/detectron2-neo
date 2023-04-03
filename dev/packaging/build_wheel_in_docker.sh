#!/bin/bash -e
# Copyright (c) Facebook, Inc. and its affiliates.

set -Eeuo pipefail

[[ -d "dev/packaging" ]] || {
  echo "Please run this script at detectron2 root!"
  exit 1
}

compute_platform=$COMPUTE_PLATFORM
pytorch_ver=$PYTORCH_VERSION
python_ver=$PYTHON_VERSION

case "$compute_platform" in
  cu*)
    image=manylinux-cuda${compute_platform/cu/}:latest
    ;;
  rocm*)
    image=manylinux-rocm:${compute_platform/rocm/}
    ;;
  cpu)
    image=manylinux-cuda101:latest
    ;;
  *)
    echo "Unrecognized compute_platform=$compute_platform"
    exit 1
    ;;
esac

# We don't run as the current user, as we need to install system packages. Instead, we'll chown output files after the build script completes.
docker run --rm \
  --mount "type=bind,source=$(pwd),target=/detectron2" \
  -e COMPUTE_PLATFORM=$compute_platform \
  -e D2_VERSION_SUFFIX="+${GITHUB_SHA:-$(git rev-parse HEAD)}-$compute_platform" \
  -e PYTHON_VERSION=$python_ver \
  -e PYTORCH_VERSION=$pytorch_ver \
  -w /detectron2 \
  pytorch/$image \
  bash -c "./dev/packaging/build_wheel.sh && chown -R $EUID:$EUID wheels/"
