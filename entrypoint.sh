#!/bin/bash

set -e

bw config server "${BW_HOST}"

declare BW_SESSION
if [ "${BW_USER}" ] && [ "${BW_PASSWORD}" ]; then
    echo 'Authenticating with username & password'
    BW_SESSION=$(bw login "${BW_USER}" --passwordenv BW_PASSWORD --raw)
elif [ "${BW_CLIENTID}" ] && [ "${BW_CLIENTSECRET}" ] && [ "${BW_PASSWORD}" ]; then
    echo 'Authenticating with api-key & password'
    bw login --apikey
    BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
fi
export BW_SESSION

bw unlock --check

# shellcheck disable=SC2016
echo 'Running `bw server` on port 8087'
bw serve --hostname all #--disable-origin-protection
