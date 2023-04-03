# detectron2-neo

This is a fork of [Detectron2](https://github.com/facebookresearch/detectron2) with prebuilt wheels for PyTorch 2.0.0 and:

||Python 3.8|Python 3.9|Python 3.10|Python 3.11|
|---|---|---|---|---|
|CPU|whl|whl|whl|whl|
|CUDA 11.7|whl|whl|whl|whl|
|CUDA 11.8|whl|whl|whl|whl|
|ROCm 5.3|whl|whl|whl|whl|
|ROCm 5.4.2|whl|whl|whl|whl|

You do not need to have CUDA Toolkit or cuDNN installed, and any existing installations (including different versions) won't conflict with PyTorch, as it comes with its own copy.[^1] [^2] [^3]

[^1]: https://discuss.pytorch.org/t/how-to-check-if-torch-uses-cudnn/21933/5
[^2]: https://discuss.pytorch.org/t/is-cuda-back-compatible/76872/4
[^3]: https://discuss.pytorch.org/t/would-pytorch-for-cuda-11-6-work-when-cuda-is-actually-12-0/169569/2
