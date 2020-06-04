#!/bin/bash
set -e

readonly APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../app" && pwd)"

docker build \
  --file "${APP_DIR}/Dockerfile" \
  --tag cyberdojotools/image_manifest_tagger \
  "${APP_DIR}"
