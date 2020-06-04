#!/bin/bash -Eeu

readonly SH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/sh" && pwd )"

"${SH_DIR}/build_tagger.sh"
