#!/bin/bash -e

#Set up cache folders
unset APPTAINER_BIND
APPTAINER_CACHEDIR=$(mktemp -d)
APPTAINER_TMPDIR=${APPTAINER_CACHEDIR}

#Confirm a valid NGC API key is available before attempting to log in / build
if ! "$(dirname "$0")/check_boltz2_api_key.sh"; then
  echo "A valid NGC API key for boltz2 is required before building. Fix the key above and re-run this script." >&2
  exit 1
fi

#Log in to NVIDIA NGC registry (boltz2 requires an authenticated pull)
cat ~/.ngc/ngc_api_key.boltz2 | apptainer registry login --username '$oauthtoken' --password-stdin docker://nvcr.io

#Build container and make readable to everyone
apptainer build --force boltz2.sif boltz2.def
chmod 640 boltz2.sif

#Should also be available via
# apptainer pull boltz2.sif oras://ghcr.io/acsrc-shoc2/boltz2/boltz2:latest
