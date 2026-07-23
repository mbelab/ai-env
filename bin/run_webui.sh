#!/usr/bin/env bash

# Run WebUI script
# mbelab


# script
api_base_temp=${OPENAI_API_BASE#*//}
api_base_temp=${api_base_temp%%/*}
host=${api_base_temp%%:*}
port=${api_base_temp#*:}

echo 'Start browser for WebUI (http://'$host':'$port')...'
echo

xdg-open 'http://'$host':'$port &
