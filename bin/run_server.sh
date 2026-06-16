#!/usr/bin/env bash

# Run model as server script
# mbelab


# defines
MODEL_LIST='./data/model_list.json'
LLAMA_BIN_DIR='./llama.cpp/build/bin'
DEFAULT_HOST='127.0.0.1'
DEFAULT_PORT='9000'
DEFAULT_ALIAS='ai-env'


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

# run model as server
echo 'Run model '$model' as server with alias '$DEFAULT_ALIAS
echo '(http://'$DEFAULT_HOST':'$DEFAULT_PORT')...'
echo
echo 'Press CTRL+C to stop server.'
echo

$LLAMA_BIN_DIR/llama-server \
    --model $model_file --alias $DEFAULT_ALIAS \
    --ui --jinja --tools all \
    --host $DEFAULT_HOST --port $DEFAULT_PORT \
    "$@"
