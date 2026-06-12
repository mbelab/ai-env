#!/usr/bin/env bash

# Setup llama.cpp script
# mbelab


# defines
LLAMA_DIR='./llama.cpp'


# script
option="$1"

# enter llama.cpp directory
cd $LLAMA_DIR

# prepare cmake build depending on option
if [[ $option = '--vulkan' ]]
then
    cmake -B build -DGGML_VULKAN=ON
else
    cmake -B build -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS
fi

# build llama.cpp
cmake --build build --config Release -j
