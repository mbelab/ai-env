#!/usr/bin/env bash

# Model manager tool
# mbelab


# defines
MODEL_LIST='./data/model_list.json'


# functions
function show_help() {
    local script_name=$1
    local model_list=$2
    local model_path=$3

    echo 'Model manager tool'
    echo
    echo 'Usage: '$script_name' verb [options]'
    echo
    echo 'Verbs:'
    echo '    help               Show this help'
    echo '    list               List models'
    echo '    show               Show model information'
    echo '    download           Download model'
    echo '    remove             Remove model'
    echo
    echo 'Options:'
    echo '    -m, --model=NAME   Use model NAME'
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

    local model_url=$(jq -r --arg model $model '.models[$model].url' $model_list)
    local model_type=$(jq -r --arg model $model '.models[$model].type' $model_list)
    local model_file=$model_path/$model'.'$model_type

    mkdir -p $model_path
    wget -q --show-progress -O $model_file $model_url
}

function remove_model() {
    local model_list=$1
    local model_path=$2
    local model=$3

    local model_type=$(jq -r --arg model $model '.models[$model].type' $model_list)
    local model_file=$model_path/$model'.'$model_type

    rm -r -f $model_file
}


# script
script=$(realpath $BASH_SOURCE)
script_name=$(basename $script)

model_list=$(realpath $MODEL_LIST)
model_path=$(dirname $model_list)/'models'

verb="$1"
shift

# handle options
model=''

for option in "$@"
do
    case $option in
        '-m='*)
            model=${option/'-m='/}
            ;;
        '--model='*)
            model=${option/'--model='/}
            ;;
        *)
            # no valid option
            ;;
    esac
done

# handle verb
case $verb in
    'list')
        list_models $model_list
        ;;
    'show')
        show_model $model_list $model
        ;;
    'download')
        download_model $model_list $model_path $model
        ;;
    'remove')
        remove_model $model_list $model_path $model
        ;;
    *)
        # no valid verb / help
        show_help $script_name $model_list $model_path
        ;;
esac

exit 0
