#!/bin/sh
set -eux

IMAGE_NAME="example-node"
printf 'IMAGE_NAME: %s' "$IMAGE_NAME"

IMAGE_TAG_NODE="test-node"
printf 'IMAGE_TAG_NODE: %s' "$IMAGE_TAG_NODE"

IMAGE_TAG_FLASK="test-flask"
printf 'IMAGE_TAG_FLASK: %s' "$IMAGE_TAG_FLASK"

IMAGE_FULL_NODE="${IMAGE_NAME}:${IMAGE_TAG_NODE}"
printf 'IMAGE_FULL_NODE: %s' "$IMAGE_FULL_NODE"

IMAGE_FULL_FLASK="${IMAGE_NAME}:${IMAGE_TAG_FLASK}"
printf 'IMAGE_FULL_FLASK: %s' "$IMAGE_FULL_FLASK"

DOCKER_NETWORK_NAME=docker_network_01

set +eu
BIN_DOCKER="$(which docker)"
[ -z "${BIN_DOCKER}" ] && echo "ERR: NO DOCKER FOUND" && exit 1
printf 'FOUND DOCKER: %s' "${BIN_DOCKER}"
EXT_PARAM="$1"
printf 'PARAMS: %s' "${EXT_PARAM}"
set -eu

# ./example-node/Dockerfile -t example-node:test-node example-node/
"${BIN_DOCKER}" build -f ./example-node/Dockerfile -t "${IMAGE_FULL_NODE}" ./example-node/
EC_BUILD=$?
[ "$EC_BUILD" != 0 ] && echo "ERR: FAILED_TO_BUILD"

"${BIN_DOCKER}" build -f ./example-flask/Dockerfile -t "${IMAGE_FULL_FLASK}" ./example-flask/ 
EC_BUILD=$?
[ "$EC_BUILD" != 0 ] && echo "ERR: FAILED_TO_BUILD"

case "$EXT_PARAM" in
  "noderun")
    "${BIN_DOCKER}" run -p3000:3000 -t "${IMAGE_FULL_NODE}"
    EC_RUN=$?
    [ "$EC_RUN" != 0 ] && echo "ERR: FAILED_TO_RUN" && exit 1
    ;;
  "noderunwithnetwork")
    docker network create "${DOCKER_NETWORK_NAME}"
    "${BIN_DOCKER}" run --name web -d --network "${DOCKER_NETWORK_NAME}" -p3000:3000 -t "${IMAGE_FULL_NODE}"
    EC_RUN=$?
    [ "$EC_RUN" != 0 ] && echo "ERR: FAILED_TO_RUN" && exit 1
    "${BIN_DOCKER}" run --name backend -d  --network "${DOCKER_NETWORK_NAME}" -p3010:3010 -t "${IMAGE_FULL_NODE}"
    EC_RUN=$?
    [ "$EC_RUN" != 0 ] && echo "ERR: FAILED_TO_RUN" && exit 1
    "${BIN_DOCKER}" run --name ping -d --network "${DOCKER_NETWORK_NAME}"  -t "alpine:3.18"
    EC_RUN=$?
    [ "$EC_RUN" != 0 ] && echo "ERR: FAILED_TO_RUN" && exit 1
    ;;
  "flaskrun")
    "${BIN_DOCKER}" run --memory=50m --cpus=1 -p5000:5000 -t "${IMAGE_FULL_FLASK}"
    EC_RUN=$?
    [ "$EC_RUN" != 0 ] && echo "ERR: FAILED_TO_RUN" && exit 1
    ;;
  "destroy")
    docker container rm -f web
    docker container rm -f backend
    docker container rm -f ping
    docker network rm "${DOCKER_NETWORK_NAME}"
    ;;
  *)
    echo "default just bulding"
    ;;
        
esac
