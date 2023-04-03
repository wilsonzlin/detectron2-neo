#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.

set -Eeuo pipefail

compute_platform=$COMPUTE_PLATFORM
d2_version_suffix=$D2_VERSION_SUFFIX
python_ver=$PYTHON_VERSION
pytorch_ver=$PYTORCH_VERSION

# Set up Torch compute platform.
# Like other torch domain libraries, we choose common GPU architectures only.
# See https://github.com/pytorch/pytorch/blob/master/torch/utils/cpp_extension.py
# and https://github.com/pytorch/vision/blob/main/packaging/pkg_helpers.sh for reference.
#
# For ROCm:
# ---------
# https://github.com/cupy/cupy/issues/4493
# https://github.com/RadeonOpenCompute/ROCm/issues/1714
# https://github.com/archlinux/svntogit-community/blob/195e3794566daa3d0a560adebc8c4d732d1ecea0/trunk/PKGBUILD#LL263C10-L263C27
# https://docs.amd.com/bundle/ROCm-Deep-Learning-Guide-v5.3.2/page/Frameworks_Installation.html
# https://hub.docker.com/layers/rocm/pytorch/rocm5.1.1_ubuntu20.04_py3.7_pytorch_staging_base/images/sha256-919a46ce1bf2a859ee6d5a4b5f27eff6769ed932c127f650eafc60fabea1f548
export FORCE_CUDA=1
case "$compute_platform" in
cu118)
  export CUDA_HOME=/usr/local/cuda-11.8/
  export TORCH_CUDA_ARCH_LIST="3.7;5.0;5.2;6.0;6.1+PTX;7.0;7.5+PTX;8.0;8.6+PTX"
  ;;
cu117)
  export CUDA_HOME=/usr/local/cuda-11.7/
  export TORCH_CUDA_ARCH_LIST="3.7;5.0;5.2;6.0;6.1+PTX;7.0;7.5+PTX;8.0;8.6+PTX"
  ;;
rocm5.4.2)
  export ROCM_HOME=/opt/rocm-5.4.2/
  export PYTORCH_ROCM_ARCH="gfx900;gfx906;gfx908;gfx90a;gfx1030"
  ;;
rocm5.3)
  export ROCM_HOME=/opt/rocm-5.3/
  export PYTORCH_ROCM_ARCH="gfx900;gfx906;gfx908;gfx90a;gfx1030"
  ;;
cpu)
  unset FORCE_CUDA
  export CUDA_VISIBLE_DEVICES=
  ;;
*)
  echo "Unrecognized COMPUTE_PLATFORM=$compute_platform"
  exit 1
  ;;
esac

# ROCm PyTorch packages for x86-64 are currently named differently.
pytorch_pkg_ver=$pytorch_ver
if [[ "$compute_platform" == rocm* ]]; then
  pytorch_pkg_ver=$pytorch_pkg_ver+$compute_platform
fi

# Set up Python.
case "$python_ver" in
3.8) python_abi=cp38-cp38 ;;
3.9) python_abi=cp39-cp39 ;;
3.10) python_abi=cp310-cp310 ;;
3.11) python_abi=cp311-cp311 ;;
*)
  echo "Unrecognized PYTHON_VERSION=$python_ver"
  exit 1
  ;;
esac
export PATH="/opt/python/$python_abi/bin:$PATH"

echo "Build Settings:"
echo "COMPUTE_PLATFORM: $compute_platform"     # e.g. rocm5.4.2
echo "D2_VERSION_SUFFIX: $d2_version_suffix"   # e.g. +d779ea63faa54fe42b9b4c280365eaafccb280d6-cu118 or ""
echo "PYTHON_VERSION: $python_ver"         # e.g. 3.11
echo "PYTORCH_VERSION: $pytorch_ver"       # e.g. 2.0.0

pip install -U pip numpy
pip install "torch==$pytorch_pkg_ver" -f "https://download.pytorch.org/whl/$compute_platform/torch_stable.html"

# use separate directories to allow parallel build
base_build_dir=build/$compute_platform-py$python_ver-pt$pytorch_ver
python setup.py \
  build -b "$base_build_dir" \
  bdist_wheel -b "$base_build_dir/build_dist" -d "wheels/$compute_platform/torch$pytorch_ver"
rm -rf "$base_build_dir"
