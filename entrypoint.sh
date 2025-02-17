#!/bin/bash

set -e

bw config server "${BW_HOST}"

declare BW_SESSION
if [ -z "${BW_UESR}" ] && [ -z "${BW_PASSWORD}" ]; then
    BW_SESSION=$(bw login "${BW_USER}" --passwordenv BW_PASSWORD --raw)
elif [ -z "${BW_CLIENTID}" ] && [ -z "${BW_CLIENT_SECRET}" ]; then
    BW_SESSION=$(bw login --apikey --raw)
fi
export BW_SESSION

bw unlock --check

# shellcheck disable=SC2016
echo 'Running `bw server` on port 8087'
bw serve --hostname all #--disable-origin-protection
