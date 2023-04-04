# detectron2-neo

This is a fork of [Detectron2](https://github.com/facebookresearch/detectron2) with prebuilt wheels for Linux x86-64, PyTorch 2.0.0 and:

||Python 3.8|Python 3.9|Python 3.10|Python 3.11|
|---|---|---|---|---|
|CPU|[whl][py3.8-cpu]|[whl][py3.9-cpu]|[whl][py3.10-cpu]|[whl][py3.11-cpu]|
|CUDA 11.7|[whl][py3.8-cu117]|[whl][py3.9-cu117]|[whl][py3.10-cu117]|[whl][py3.11-cu117]|
|CUDA 11.8|[whl][py3.8-cu118]|[whl][py3.9-cu118]|[whl][py3.10-cu118]|[whl][py3.11-cu118]|
|ROCm 5.3|[whl][py3.8-rocm5.3]|[whl][py3.9-rocm5.3]|[whl][py3.10-rocm5.3]|-|
|ROCm 5.4.2|[whl][py3.8-rocm5.4.2]|[whl][py3.9-rocm5.4.2]|[whl][py3.10-rocm5.4.2]|-|

[py3.8-cpu]: https://static.wilsonl.in/detectron2-neo/cpu/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cpu-cp38-cp38-linux_x86_64.whl
[py3.9-cpu]: https://static.wilsonl.in/detectron2-neo/cpu/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cpu-cp39-cp39-linux_x86_64.whl
[py3.10-cpu]: https://static.wilsonl.in/detectron2-neo/cpu/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cpu-cp310-cp310-linux_x86_64.whl
[py3.11-cpu]: https://static.wilsonl.in/detectron2-neo/cpu/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cpu-cp311-cp311-linux_x86_64.whl

[py3.8-cu117]: https://static.wilsonl.in/detectron2-neo/cu117/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu117-cp38-cp38-linux_x86_64.whl
[py3.9-cu117]: https://static.wilsonl.in/detectron2-neo/cu117/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu117-cp39-cp39-linux_x86_64.whl
[py3.10-cu117]: https://static.wilsonl.in/detectron2-neo/cu117/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu117-cp310-cp310-linux_x86_64.whl
[py3.11-cu117]: https://static.wilsonl.in/detectron2-neo/cu117/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu117-cp311-cp311-linux_x86_64.whl

[py3.8-cu118]: https://static.wilsonl.in/detectron2-neo/cu118/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu118-cp38-cp38-linux_x86_64.whl
[py3.9-cu118]: https://static.wilsonl.in/detectron2-neo/cu118/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu118-cp39-cp39-linux_x86_64.whl
[py3.10-cu118]: https://static.wilsonl.in/detectron2-neo/cu118/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu118-cp310-cp310-linux_x86_64.whl
[py3.11-cu118]: https://static.wilsonl.in/detectron2-neo/cu118/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.cu118-cp311-cp311-linux_x86_64.whl

[py3.8-rocm5.3]: https://static.wilsonl.in/detectron2-neo/rocm5.3/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.rocm5.3-cp38-cp38-linux_x86_64.whl
[py3.9-rocm5.3]: https://static.wilsonl.in/detectron2-neo/rocm5.3/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.rocm5.3-cp39-cp39-linux_x86_64.whl
[py3.10-rocm5.3]: https://static.wilsonl.in/detectron2-neo/rocm5.3/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.rocm5.3-cp310-cp310-linux_x86_64.whl

[py3.8-rocm5.4.2]: https://static.wilsonl.in/detectron2-neo/rocm5.4.2/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.rocm5.4.2-cp38-cp38-linux_x86_64.whl
[py3.9-rocm5.4.2]: https://static.wilsonl.in/detectron2-neo/rocm5.4.2/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.rocm5.4.2-cp39-cp39-linux_x86_64.whl
[py3.10-rocm5.4.2]: https://static.wilsonl.in/detectron2-neo/rocm5.4.2/torch2.0.0/detectron2-0.6+acd0dd7b565e1e6b5f7bff5ef49020c3275d1c87.rocm5.4.2-cp310-cp310-linux_x86_64.whl

You do not need to have CUDA Toolkit or cuDNN installed, and any existing installations (including different versions) won't conflict with PyTorch, as it comes with its own copy.[^1] [^2] [^3]

[^1]: https://discuss.pytorch.org/t/how-to-check-if-torch-uses-cudnn/21933/5
[^2]: https://discuss.pytorch.org/t/is-cuda-back-compatible/76872/4
[^3]: https://discuss.pytorch.org/t/would-pytorch-for-cuda-11-6-work-when-cuda-is-actually-12-0/169569/2
