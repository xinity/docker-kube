#!/bin/bash

set -eo pipefail
shopt -s nullglob

main() {
DUID=${DUID:-999}
DGID=${DGID:-999}

groupmod -o -g "$DGID" docker
usermod -o -u "$DUID" docker

set -- /usr/local/bin/docker kube "$@"
exec "$@"
}

main "$@"
