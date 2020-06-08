#!/bin/bash
set -e
set -x
# Workings/example on using image_manifest_tagger

readonly TMP_DIR=$(mktemp -d XXXXX)
remove_tmp_dir() { rm -rf "${TMP_DIR}" > /dev/null; }
trap remove_tmp_dir INT EXIT

readonly SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly START_POINT_DIR="${SRC_DIR}/start_point"  # <<<<<<<
readonly TAG=${1:-def84a4}                         # <<<<<<<

readonly START_POINT_IMAGE_NAME=$( \
  docker run \
    --volume "${START_POINT_DIR}:/start_point:rw" \
    --rm \
    cyberdojofoundation/image_manifest_tagger \
    "${TAG}")

cat << EOF > "${TMP_DIR}/Dockerfile"
FROM alpine:latest
COPY . /start_point
EOF

docker build \
  --file "${TMP_DIR}/Dockerfile" \
  --tag "${START_POINT_IMAGE_NAME}" \
  "${START_POINT_DIR}"

# How to get dir out...
#id=$(docker create "${START_POINT_IMAGE_NAME}")
#docker cp "${id}":/start_point/. "${MY_DIR}/tmp"
#docker rm --force "${id}"
