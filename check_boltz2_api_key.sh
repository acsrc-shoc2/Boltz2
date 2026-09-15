#!/bin/bash

#Credentials for NGC
NGC_API_KEY=$(cat ~/.ngc/ngc_api_key.boltz2 2>/dev/null)
if [[ -n "$NGC_API_KEY" ]]; then
  # lock down permissions in case this file predates this check (e.g. created world/group-readable)
  chmod 700 ~/.ngc
  chmod 600 ~/.ngc/ngc_api_key.boltz2
  echo "NGC API Key for boltz2 found at ~/.ngc/ngc_api_key.boltz2"
  echo "Testing"
  RET_CODE=$(curl -s -o /dev/null -w "%{http_code}\n"     "https://api.ngc.nvidia.com/v2/orgs?page-size=500"     -H "Authorization: Bearer $NGC_API_KEY")
  if [ "$RET_CODE" -eq 200 ]; then
    echo "API key is valid"
    exit 0
  elif [ "$RET_CODE" -eq 401 ]; then
    echo "API key is invalid or expired"
    echo "delete ~/.ngc/ngc_api_key.boltz2 and rerun check_boltz2_api_key.sh"
    exit 1
  else
    echo "Unexpected response code: $RET_CODE"
    echo "delete ~/.ngc/ngc_api_key.boltz2 and rerun check_boltz2_api_key.sh"
    exit 1
  fi
else
  echo "NGC API Key for boltz2 not found.  Create one at:"
  echo "https://build.nvidia.com/mit/boltz2"
  echo "and paste it into this window"
  read -r NGC_API_KEY
  mkdir -p ~/.ngc/
  chmod 700 ~/.ngc
  echo "$NGC_API_KEY" > ~/.ngc/ngc_api_key.boltz2
  chmod 600 ~/.ngc/ngc_api_key.boltz2
  echo "Key saved at ~/.ngc/ngc_api_key.boltz2.  Rereun check_boltz2_api_key.sh to confirm"
  exit 1
fi
