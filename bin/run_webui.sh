#!/usr/bin/env bash

# Run WebUI script
# mbelab


# script
echo 'Start browser for WebUI (http://'$AI_ENV_SERVER_HOST':'$AI_ENV_SERVER_PORT')...'
echo

xdg-open 'http://'$AI_ENV_SERVER_HOST':'$AI_ENV_SERVER_PORT &
