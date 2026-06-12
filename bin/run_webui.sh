#!/usr/bin/env bash

# Run model in WebUI script
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
port="$2"

# handle model and port
model_type=$(jq -r --arg model $model '.models[$model].type' $model_list)
model_file=$model_path/$model'.'$model_type

if [ -z $port ]
then
    port=$DEFAULT_PORT
fi

# start browser with WebUI
xdg-open 'http://'$DEFAULT_IP':'$port &

# run model as server with WebUI
$LLAMA_BIN_DIR/llama-server \
    -m $model_file \
    --jinja -c 0 --alias $model \
    --host $DEFAULT_IP --port $port
