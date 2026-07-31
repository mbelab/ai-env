#!/usr/bin/env bash

# Run server script
# mbelab


# script
model_list=$AI_ENV_MODEL_LIST
model_path=$AI_ENV_MODEL_PATH

api_base_temp=${OPENAI_API_BASE#*//}
api_base_temp=${api_base_temp%%/*}
host=${api_base_temp%%:*}
port=${api_base_temp#*:}

model="$1"

# prepare run options
run_options=(
    --host $host
    --port $port
    --ui
    --jinja
    --tools all
)

# handle model
if [[ -z $model ]]
then
    # start server in router mode
    # this may include CPU offloading for MoE models and MTP in future
    run_options+=(
        --models-dir $model_path
        --no-models-autoload
        # --cpu-moe
        # --spec-type draft-mtp
        # --spec-draft-n-max 2
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
        --alias $AI_ENV_MODEL_ALIAS
    )

    if [[ ! -z $mmproj_file ]]
    then
        run_options+=(--mmproj $model_path/$model/$mmproj_file)
    fi

    echo 'Run server with model '$model' as '$AI_ENV_MODEL_ALIAS'...'
fi

# run server
echo '(http://'$host':'$port')'
echo
echo 'Press CTRL+C to stop server.'
echo

$AI_ENV_LLAMA_BIN/llama-server "${run_options[@]}" "$@"
