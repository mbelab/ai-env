#!/usr/bin/env bash

# Run model in CLI script
# mbelab


# script
model_list=$AI_ENV_MODEL_LIST
model_path=$AI_ENV_MODEL_PATH

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

# run model in CLI
echo 'Run model '$model' in CLI...'
echo

$AI_ENV_LLAMA_BIN/llama-cli \
    -m $model_file \
    "$@"
