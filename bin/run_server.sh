#!/usr/bin/env bash

# Run model as server script
# mbelab


# defines
MODEL_LIST='./data/model_list.json'
LLAMA_BIN_DIR='./llama.cpp/build/bin'
DEFAULT_IP='127.0.0.1'
DEFAULT_PORT='8080'


# script
model_list=$(realpath $MODEL_LIST)
model_path=$(dirname $model_list)/'models'

model="$1"
shift

# handle model
model_type=$(jq -r --arg model $model '.models[$model].type' $model_list)
model_file=$model_path/$model'.'$model_type

if [[ ! -e $model_file ]]
then
    echo 'Model file '$model_file' not found. Abort.'
    exit 2  # no such file or directory
fi

# run model as server
$LLAMA_BIN_DIR/llama-server \
    -m $model_file -c 0 \
    --host $DEFAULT_IP --port $DEFAULT_PORT \
    "$@"
