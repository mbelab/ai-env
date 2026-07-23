#!/usr/bin/env bash

# Setup llama.cpp script
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

if [[ $option = '--cuda' ]]
then
    build_options+=(-DGGML_CUDA=ON)
fi

# build llama.cpp
cmake -S $AI_ENV_LLAMA -B $AI_ENV_LLAMA_BUILD "${build_options[@]}"
cmake --build $AI_ENV_LLAMA_BUILD --config Release -j
