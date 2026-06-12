#!/usr/bin/env bash

# Run model in benchmark script
# mbelab


# defines
MODEL_LIST='./data/model_list.json'
LLAMA_BIN_DIR='./llama.cpp/build/bin'


# script
model_list=$(realpath $MODEL_LIST)
model_path=$(dirname $model_list)/'models'

model="$1"
shift

# handle model
model_type=$(jq -r --arg model $model '.models[$model].type' $model_list)
model_file=$model_path/$model'.'$model_type

# run model in benchmark
$LLAMA_BIN_DIR/llama-bench \
    -m $model_file \
    "$@"
