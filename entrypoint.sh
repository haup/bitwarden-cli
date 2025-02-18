#!/bin/bash

set -e

bw config server "${BW_HOST}"

declare BW_SESSION
if [ "${BW_UESR}" ] && [ "${BW_PASSWORD}" ]; then
    BW_SESSION=$(bw login "${BW_USER}" --passwordenv BW_PASSWORD --raw)
elif [ "${BW_CLIENTID}" ] && [ "${BW_CLIENTSECRET}" ]; then
    BW_SESSION=$(bw login --apikey --raw)
fi
export BW_SESSION

bw unlock --check

# shellcheck disable=SC2016
echo 'Running `bw server` on port 8087'
bw serve --hostname all #--disable-origin-protection
