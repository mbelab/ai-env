#!/usr/bin/env bash

# Run model in WebUI script
# mbelab


# defines
MODEL_LIST='./data/model_list.json'
LLAMA_BIN_DIR='./llama.cpp/build/bin'
DEFAULT_IP='127.0.0.1'
DEFAULT_PORT='9000'


# script
model_list=$(realpath $MODEL_LIST)
model_path=$(dirname $model_list)/'models'

model="$1"
shift

# handle model
if [[ -z $model ]]
then
    echo 'No model provided. Abort.'
    exit 1  # operation not permitted
fi

model_type=$(jq -r --arg model $model '.models[$model].type' $model_list)
model_file=$model_path/$model'.'$model_type

if [[ ! -e $model_file ]]
then
    echo 'Model file '$model_file' not found. Abort.'
    exit 2  # no such file or directory
fi

# start browser with WebUI
echo 'Start browser for WebUI (http://'$DEFAULT_IP':'$DEFAULT_PORT')...'
echo

xdg-open 'http://'$DEFAULT_IP':'$DEFAULT_PORT &

# run model as server with WebUI
echo 'Run model '$model' as server (http://'$DEFAULT_IP':'$DEFAULT_PORT')...'
echo

$LLAMA_BIN_DIR/llama-server \
    -m $model_file -c 0 \
    --jinja --tools all --alias $model \
    --host $DEFAULT_IP --port $DEFAULT_PORT \
    "$@"
