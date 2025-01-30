#!/bin/sh
set -eux

IMAGE_NAME="flask-example"
printf 'IMAGE_NAME: %s' "$IMAGE_NAME"
IMAGE_TAG="test"
printf 'IMAGE_TAG: %s' "$IMAGE_TAG"
IMAGE_FULL="${IMAGE_NAME}:${IMAGE_TAG}"
printf 'IMAGE_FULL: %s' "$IMAGE_FULL"

set +eu
BIN_DOCKER="$(which docker)"
[ -z "${BIN_DOCKER}" ] && echo "ERR: NO DOCKER FOUND" && exit 1
printf 'FOUND DOCKER: %s' "${BIN_DOCKER}"
EXT_PARAM="$1"
printf 'PARAMS: %s' "${EXT_PARAM}"
set -eu


"${BIN_DOCKER}" build -t "${IMAGE_FULL}" .
EC_BUILD=$?
[ "$EC_BUILD" != 0 ] && echo "ERR: FAILED_TO_BUILD"

case "$EXT_PARAM" in
  "buildandrun")
    "${BIN_DOCKER}" run -p3000:3000 -t "${IMAGE_FULL}"
    EC_RUN=$?
    [ "$EC_RUN" != 0 ] && echo "ERR: FAILED_TO_RUN"
    ;;
  *)
    echo "default just bulding"
    ;;
        
esac
