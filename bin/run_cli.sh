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

model_file=$(jq -r --arg model $model '.models[$model].model_file' $model_list)
mmproj_file=$(jq -r --arg model $model '.models[$model].mmproj_file' $model_list)

if [[ ! -e $model_path/$model/$model_file ]]
then
    echo 'Model file not found. Abort.'
    exit 2  # no such file or directory
fi

# prepare run options
run_options=(
    --model $model_path/$model/$model_file
)

if [[ ! -z $mmproj_file ]]
then
    run_options+=(--mmproj $model_path/$model/$mmproj_file)
fi

# run model in CLI
echo 'Run model '$model' in CLI...'
echo

$AI_ENV_LLAMA_BIN/llama-cli "${run_options[@]}" "$@"
