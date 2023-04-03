#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.

set -Eeuo pipefail

ldconfig  # https://github.com/NVIDIA/nvidia-docker/issues/854

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$script_dir/pkg_helpers.sh"

echo "Build Settings:"
echo "COMPUTE_PLATFORM: $COMPUTE_PLATFORM"     # e.g. rocm5.4.2
echo "D2_VERSION_SUFFIX: $D2_VERSION_SUFFIX"   # e.g. +d779ea63faa54fe42b9b4c280365eaafccb280d6-cu118 or ""
echo "PYTHON_VERSION: $PYTHON_VERSION"         # e.g. 3.11
echo "PYTORCH_VERSION: $PYTORCH_VERSION"       # e.g. 2.0.0

setup_cuda
setup_wheel_python

yum install ninja-build -y
ln -sv /usr/bin/ninja-build /usr/bin/ninja || true

pip install -U pip numpy
pip install "torch==$PYTORCH_VERSION" \
  -f "https://download.pytorch.org/whl/$COMPUTE_PLATFORM/torch_stable.html"

# use separate directories to allow parallel build
BASE_BUILD_DIR=build/$COMPUTE_PLATFORM-py$PYTHON_VERSION-pt$PYTORCH_VERSION
python setup.py \
  build -b "$BASE_BUILD_DIR" \
  bdist_wheel -b "$BASE_BUILD_DIR/build_dist" -d "wheels/$COMPUTE_PLATFORM/torch$PYTORCH_VERSION"
rm -rf "$BASE_BUILD_DIR"
