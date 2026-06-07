#!/usr/bin/env bash

# Get model script


# defines
MODEL_LIST='./data/model_list.json'
DOWNLOAD_DIR='./data/models/'


# functions
function show_help() {
    local script_name=$1

    echo 'Get model script'
    echo
    echo 'Usage: '$script_name' verb [options]'
    echo
    echo 'Verbs:'
    echo '    help               Show this help'
    echo '    list               List models in '$MODEL_LIST
    echo '    show               Show model information'
    echo '    download           Download model to '$DOWNLOAD_DIR
    echo '    remove             Remove model from '$DOWNLOAD_DIR
    echo
    echo 'Options:'
    echo '    -m, --model=NAME   Use model NAME'
    echo
    echo '(c) mbelab'
    echo
}

function list_models() {
    local model_list=$1

    echo 'TODO'
    echo
}

function show_model() {
    local model_list=$1
    local model=$2

    echo 'TODO'
    echo
}

function download_model() {
    local model_list=$1
    local model=$2

    echo 'TODO'
    echo
}

function remove_model() {
    local model=$1

    echo 'TODO'
    echo
}


# script
script=$(realpath $BASH_SOURCE)
script_name=$(basename $script)

verb="$1"
shift

# handle options
model=''

for option in "$@"
do
    case $option in
        '-m')
            model=${option/'-m='/}
            ;;
        '--model')
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
        list_models $MODEL_LIST
        exit 0
        ;;
    'show')
        show_model $MODEL_LIST $model
        exit 0
        ;;
    'download')
        download_model $MODEL_LIST $model
        exit 0
        ;;
    'remove')
        remove_model $model
        exit 0
        ;;
    *)
        # no valid verb / help
        show_help $script_name
        exit 0
        ;;
esac
