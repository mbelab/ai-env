#!/usr/bin/env bash

# Setup python venv script
# mbelab


# script
python3 -m venv $AI_ENV_VENV
$AI_ENV_VENV_PYTHON -m pip install pip --upgrade --no-warn-script-location
