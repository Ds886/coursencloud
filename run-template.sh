#!/bin/sh
set -eux
K_NS=default
printf 'K_NS: %s' "${K_NS}"

set +eu
BIN_KUBECTL="$(which kubectl)"
[ -z "${BIN_KUBECTL}" ] && echo "ERR: NO KUBECTL FOUND" && exit 1
printf 'FOUND KUBECTL: %s\n' "${BIN_KUBECTL}"
EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu

case "$EXT_PARAM" in
  "command-a")
    echo "command-a"
    ;;

  "destroy")
    ;;

  *)
    echo "default just bulding"
    ;;
        
esac
