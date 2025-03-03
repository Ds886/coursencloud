#!/bin/sh
set -eux
K_NS=ex04
printf 'K_NS: %s' "${K_NS}"

AWS_NEWUESR_NAME=checkuser
AWS_NEWUESR_GROUP=checkgroup

set +eu
BIN_AWS="$(which aws)"
[ -z "${BIN_AWS}" ] && echo "ERR: NO AWS FOUND" && exit 1
printf 'FOUND AWS: %s\n' "${BIN_AWS}"
EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu

case "$EXT_PARAM" in
  "deploy")
    "${BIN_AWS}" iam create-group --username "${AWS_NEWUESR_GROUP}"
    "${BIN_AWS}" iam create-user --username "${AWS_NEWUESR_NAME}"
    "${BIN_AWS}" iam add-user-to-group --user-name "${AWS_NEWUESR_NAME}" --group-name "${AWS_NEWUESR_GROUP}"
    ;;

  "destroy")
    "${BIN_AWS}" iam remove-user-to-group --user-name "${AWS_NEWUESR_NAME}" --group-name "${AWS_NEWUESR_GROUP}"
    "${BIN_AWS}" iam delete-user  --username "${AWS_NEWUESR_NAME}"
    "${BIN_AWS}" iam delete-group --username "${AWS_NEWUESR_GROUP}"
    ;;

  *)
    echo "default just bulding"
    ;;
        
esac
