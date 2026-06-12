#!/usr/bin/env bash

# Setup llama.cpp for python script
# mbelab


# script
option="$1"

# prepare cmake args for pip install depending on option
if [[ $option = '--vulkan' ]]
then
    export CMAKE_ARGS="-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS -DGGML_VULKAN=on"
else
    export CMAKE_ARGS="-DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS"
fi

# build llama-cpp-python
pip install llama-cpp-python --force-reinstall --no-cache-dir
