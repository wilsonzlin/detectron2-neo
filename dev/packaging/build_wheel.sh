#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.

set -Eeuo pipefail

setup_cuda() {
  # Now work out the CUDA settings
  # Like other torch domain libraries, we choose common GPU architectures only.
  # See https://github.com/pytorch/pytorch/blob/master/torch/utils/cpp_extension.py
  # and https://github.com/pytorch/vision/blob/main/packaging/pkg_helpers.sh for reference.
  export FORCE_CUDA=1
  case "$COMPUTE_PLATFORM" in
    cu118)
      export CUDA_HOME=/usr/local/cuda-11.8/
      export TORCH_CUDA_ARCH_LIST="3.7;5.0;5.2;6.0;6.1+PTX;7.0;7.5+PTX;8.0;8.6+PTX"
      ;;
    cu117)
      export CUDA_HOME=/usr/local/cuda-11.7/
      export TORCH_CUDA_ARCH_LIST="3.7;5.0;5.2;6.0;6.1+PTX;7.0;7.5+PTX;8.0;8.6+PTX"
      ;;
    rocm5.4.2)
      # https://github.com/cupy/cupy/issues/4493
      export ROCM_HOME=/opt/rocm-5.4.2/
      # https://github.com/RadeonOpenCompute/ROCm/issues/1714
      # https://github.com/archlinux/svntogit-community/blob/195e3794566daa3d0a560adebc8c4d732d1ecea0/trunk/PKGBUILD#LL263C10-L263C27
      # https://docs.amd.com/bundle/ROCm-Deep-Learning-Guide-v5.3.2/page/Frameworks_Installation.html
      # https://hub.docker.com/layers/rocm/pytorch/rocm5.1.1_ubuntu20.04_py3.7_pytorch_staging_base/images/sha256-919a46ce1bf2a859ee6d5a4b5f27eff6769ed932c127f650eafc60fabea1f548
      export PYTORCH_ROCM_ARCH="gfx900;gfx906;gfx908;gfx90a;gfx1030"
      ;;
    cpu)
      unset FORCE_CUDA
      export CUDA_VISIBLE_DEVICES=
      ;;
    *)
      echo "Unrecognized COMPUTE_PLATFORM=$COMPUTE_PLATFORM"
      exit 1
      ;;
  esac
}

setup_wheel_python() {
  case "$PYTHON_VERSION" in
    3.8) python_abi=cp38-cp38 ;;
    3.9) python_abi=cp39-cp39 ;;
    3.10) python_abi=cp310-cp310 ;;
    3.11) python_abi=cp311-cp311 ;;
    *)
      echo "Unrecognized PYTHON_VERSION=$PYTHON_VERSION"
      exit 1
      ;;
  esac
  export PATH="/opt/python/$python_abi/bin:$PATH"
}

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
