#!/usr/bin/env bash

# Get OpenCode script
# mbelab


# defines
RELEASE_API='https://api.github.com/repos/anomalyco/opencode/releases/latest'
TARGET_NAME='opencode-desktop-linux-x86_64.AppImage'


# script
download_url=$(curl -s $RELEASE_API | \
    jq -r --arg TARGET_NAME $TARGET_NAME '.assets[] | select(.name == $TARGET_NAME) | .browser_download_url')

rm -f $AI_ENV_OPENCODE
wget -q --show-progress -O $AI_ENV_OPENCODE $download_url
chmod +x $AI_ENV_OPENCODE
