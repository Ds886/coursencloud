#!/bin/sh
set -eux
K_NS=ex05
printf 'K_NS: %s' "${K_NS}"

set +eu
BIN_KUBECTL="$(which kubectl)"
[ -z "${BIN_KUBECTL}" ] && echo "ERR: NO KUBECTL FOUND" && exit 1
printf 'FOUND KUBECTL: %s\n' "${BIN_KUBECTL}"
BIN_HELM="$(which helm)"
[ -z "${BIN_HELM}" ] && echo "ERR: NO HELM FOUND" && exit 1
printf 'FOUND HELM: %s\n' "${BIN_HELM}"
EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu

HELM_PATH=chart/hello
HELM_NAME=hello


case "$EXT_PARAM" in
  "deploy")
    helm upgrade --install -n "${K_NS}" "${HELM_NAME}" "${HELM_PATH}"
    helm upgrade --install -n "${K_NS}" "${HELM_NAME}2" "${HELM_PATH}"
    ;;

  "status")
    helm status -n "${K_NS}" "${HELM_NAME}"
    helm status -n "${K_NS}" "${HELM_NAME}2"
    ;;

  "destroy")
    helm -n "${K_NS}" uninstall "${HELM_NAME}"
    helm -n "${K_NS}" uninstall "${HELM_NAME}2"
    ;;

  *)
    echo "default just bulding"
    ;;
        
esac
