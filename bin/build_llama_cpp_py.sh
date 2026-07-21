#!/usr/bin/env bash

# Setup llama.cpp for python script
# mbelab


# script
option="$1"

# prepare build options
build_options=(
    -DGGML_BLAS=ON
    -DGGML_BLAS_VENDOR=OpenBLAS
    -DCMAKE_C_FLAGS="-march=native"
    -DCMAKE_CXX_FLAGS="-march=native"
)

if [[ $option = '--vulkan' ]]
then
    build_options+=(-DGGML_VULKAN=ON)
fi

# build llama-cpp-python
export CMAKE_ARGS="${build_options[*]}"
pip install llama-cpp-python --force-reinstall --no-cache-dir --no-warn-script-location
