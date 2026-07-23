#!/usr/bin/env bash

# Run model as server script
# mbelab


# defines
DEFAULT_HOST='127.0.0.1'
DEFAULT_PORT='9000'
DEFAULT_ALIAS='ai-env'


# script
model_list=$AI_ENV_MODEL_LIST
model_path=$AI_ENV_MODEL_PATH

model="$1"

# prepare run options
run_options=(
    --host $DEFAULT_HOST
    --port $DEFAULT_PORT
    --ui
    --jinja
    --tools all
)

# handle model
if [[ -z $model ]]
then
    # start server in router mode
    run_options+=(
        --models-dir $model_path
        --no-models-autoload
    )

    echo 'Run server in router mode...'
else
    # start server with defined model
    shift

    model_file=$(jq -r --arg model $model '.models[$model].model_file' $model_list)
    mmproj_file=$(jq -r --arg model $model '.models[$model].mmproj_file' $model_list)

    if [[ ! -e $model_path/$model/$model_file ]]
    then
        echo 'Model file not found. Abort.'
        exit 2  # no such file or directory
    fi

    run_options+=(
        --model $model_path/$model/$model_file
        --alias $DEFAULT_ALIAS
    )

    if [[ ! -z $mmproj_file ]]
    then
        run_options+=(--mmproj $model_path/$model/$mmproj_file)
    fi

    echo 'Run server with model '$model' as '$DEFAULT_ALIAS'...'
fi

# run model as server
echo '(http://'$DEFAULT_HOST':'$DEFAULT_PORT')'
echo
echo 'Press CTRL+C to stop server.'
echo

$AI_ENV_LLAMA_BIN/llama-server "${run_options[@]}" "$@"
