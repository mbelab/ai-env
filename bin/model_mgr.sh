#!/usr/bin/env bash

# Model manager tool
# mbelab


# functions
function show_help() {
    local script_name=$1
    local model_list=$2
    local model_path=$3

    echo 'Model manager tool'
    echo
    echo 'Usage: '$script_name' verb [model]'
    echo
    echo 'Verbs:'
    echo '    help               Show this help'
    echo '    list               List models'
    echo '    show               Show [model] information'
    echo '    download           Download [model]'
    echo '    remove             Remove [model]'
    echo
    echo 'Model list: '$model_list
    echo 'Model path: '$model_path
    echo
    echo '(c) mbelab'
    echo
}

function list_models() {
    local model_list=$1

    jq -r '.models | keys[]' $model_list
}

function show_model() {
    local model_list=$1
    local model=$2

    jq -r --arg model $model '.models[$model]' $model_list
}

function download_model() {
    local model_list=$1
    local model_path=$2
    local model=$3

    local base_url=$(jq -r --arg model $model '.models[$model].base_url' $model_list)
    local model_file=$(jq -r --arg model $model '.models[$model].model_file' $model_list)
    local mmproj_file=$(jq -r --arg model $model '.models[$model].mmproj_file' $model_list)

    mkdir -p $model_path/$model
    wget -q --show-progress -O $model_path/$model/$model_file $base_url/$model_file

    if [[ ! -z $mmproj_file ]]
    then
        wget -q --show-progress -O $model_path/$model/$mmproj_file $base_url/$mmproj_file
    fi
}

function remove_model() {
    local model_path=$1
    local model=$2

    rm -r -f $model_path/$model*
}


# script
script=$(realpath $BASH_SOURCE)
script_name=$(basename $script)

model_list=$AI_ENV_MODEL_LIST
model_path=$AI_ENV_MODEL_PATH

if [[ ! -e $model_list ]]
then
    echo 'Model list '$model_list' not found. Abort.'
    exit 2  # no such file or directory
fi

verb="$1"
model="$2"

# handle verb
case $verb in
    'list')
        list_models $model_list
        ;;
    'show')
        if [[ -z $model ]]
        then
            echo 'No model provided. Abort.'
            exit 1  # operation not permitted
        fi

        show_model $model_list $model
        ;;
    'download')
        if [[ -z $model ]]
        then
            echo 'No model provided. Abort.'
            exit 1  # operation not permitted
        fi

        download_model $model_list $model_path $model
        ;;
    'remove')
        if [[ -z $model ]]
        then
            echo 'No model provided. Abort.'
            exit 1  # operation not permitted
        fi

        remove_model $model_path $model
        ;;
    *)
        # no valid verb / help
        show_help $script_name $model_list $model_path
        ;;
esac
