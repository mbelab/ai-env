#!/usr/bin/env bash

# Setup python venv script
# mbelab


# defines
VENV_DIR='./.venv'
VENV_PYTHON=$VENV_DIR/'bin/python3'


# script
python3 -m venv $VENV_DIR
$VENV_PYTHON -m pip install pip --upgrade --no-warn-script-location
