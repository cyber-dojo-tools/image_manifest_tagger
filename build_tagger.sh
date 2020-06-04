#!/bin/bash
set -e

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker build \
  --file "${MY_DIR}/Dockerfile" \
  --tag cyberdojotools/image_manifest_tagger \
  "${MY_DIR}"
