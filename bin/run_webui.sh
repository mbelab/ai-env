#!/usr/bin/env bash

# Run WebUI script
# mbelab


# defines
DEFAULT_IP='127.0.0.1'
DEFAULT_PORT='9000'


# script
echo 'Start browser for WebUI (http://'$DEFAULT_IP':'$DEFAULT_PORT')...'
echo

xdg-open 'http://'$DEFAULT_IP':'$DEFAULT_PORT &
