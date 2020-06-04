#!/bin/bash -Eeu

readonly SH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/sh" && pwd )"

"${SH_DIR}/build_docker_image.sh"
"${SH_DIR}/on_ci_publish_image.sh"
