#!/bin/bash -e
# Copyright (c) Facebook, Inc. and its affiliates.

set -Eeuo pipefail

[[ -d "dev/packaging" ]] || {
  echo "Please run this script at detectron2 root!"
  exit 1
}

build_one() {
  compute_platform=$1
  pytorch_ver=$2

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

  py_versions=(3.8 3.9 3.10 3.11)

  for py in "${py_versions[@]}"; do
    docker run --rm -it \
      --user $EUID:$EUID \
      --mount "type=bind,source=$(pwd),target=/detectron2" \
      -e COMPUTE_PLATFORM=$compute_platform \
      -e D2_VERSION_SUFFIX=+$(git rev-parse HEAD)-$compute_platform \
      -e PYTHON_VERSION=$py \
      -e PYTORCH_VERSION=$pytorch_ver \
      -w /detectron2 \
      pytorch/$image \
      ./dev/packaging/build_wheel.sh
  done
}

if [[ -n "$1" ]] && [[ -n "$2" ]]; then
  build_one "$1" "$2"
else
  build_one cu118 2.0.0
  build_one cu117 2.0.0
  build_one rocm5.4.2 2.0.0
  build_one cpu 2.0.0
fi
