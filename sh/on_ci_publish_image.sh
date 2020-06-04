#!/bin/bash -Eeu

readonly SH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${SH_DIR}/image_name.sh"

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci_publish_tagged_images()
{
  if ! on_ci; then
    echo 'not on CI so not publishing image'
    return
  fi
  echo 'on CI so publishing image'
  # DOCKER_USERNAME, DOCKER_PASSWORD are in ci context
  echo "${DOCKER_PASSWORD}" | docker login --username "${DOCKER_USERNAME}" --password-stdin
  docker push "$(image_name)"
  docker logout
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci()
{
  set +u
  [ -n "${CIRCLECI}" ]
  local -r result=$?
  set -u
  [ "${result}" == '0' ]
}

# - - - - - - - - - - - - - - - - - - - - - - - -
on_ci_publish_tagged_images
