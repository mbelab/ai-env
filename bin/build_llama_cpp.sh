#!/usr/bin/env bash

# Setup llama.cpp script
# mbelab


# script
option="$1"

# enter llama.cpp directory
cd $AI_ENV_LLAMA

# prepare cmake build depending on option
if [[ $option = '--vulkan' ]]
then
    cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS -DGGML_VULKAN=ON
else
    cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
fi

# build llama.cpp
cmake --build build --config Release -j
