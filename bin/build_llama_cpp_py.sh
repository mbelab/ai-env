#!/usr/bin/env bash

# Setup llama.cpp for python script
# mbelab


# script
option="$1"

# prepare build options
build_options=(
    -DCMAKE_C_FLAGS="-march=native"
    -DCMAKE_CXX_FLAGS="-march=native"
)

if [[ $option = '--openblas' ]]
then
    build_options+=(-DGGML_BLAS=ON)
    build_options+=(-DGGML_BLAS_VENDOR=OpenBLAS)
fi

if [[ $option = '--vulkan' ]]
then
    build_options+=(-DGGML_VULKAN=ON)
fi

if [[ $option = '--cuda' ]]
then
    build_options+=(-DGGML_CUDA=ON)
fi

# build llama-cpp-python
export CMAKE_ARGS="${build_options[*]}"
pip install llama-cpp-python --force-reinstall --no-cache-dir --no-warn-script-location
