#!/bin/bash
set -e

readonly SH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
readonly APP_DIR="$(cd "${SH_DIR}"/../app && pwd)"

source "${SH_DIR}/image_name.sh"

docker build \
  --file "${APP_DIR}/Dockerfile" \
  --tag "$(image_name)" \
  "${APP_DIR}"
