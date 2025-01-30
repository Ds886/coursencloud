#!/bin/sh
set -eux
K_NS=ex02-multitier
NAME_PREFIX=ex02-multitier-
PATH_OBJ=objects

set +eu
BIN_KUBECTL="$(which kubectl)"
[ -z "${BIN_KUBECTL}" ] && echo "ERR: NO KUBECTL FOUND" && exit 1
printf 'FOUND KUBECTL: %s\n' "${BIN_KUBECTL}"

EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu

createobj()
{
  OBJ_NAME="${1}"
  "${BIN_KUBECTL}" apply -n "${K_NS}" -f "${PATH_OBJ}/${OBJ_NAME}" 
}

deleteobj()
{
  OBJ_NAME="${1}"
  "${BIN_KUBECTL}" delete -n "${K_NS}" -f "${PATH_OBJ}/${OBJ_NAME}" || true
}
case "$EXT_PARAM" in
  "nscreate")
    # "${BIN_KUBECTL}" create  namespace "${K_NS}" || true
    ;;

  "deploy")
    # "${BIN_KUBECTL}" create  namespace "${K_NS}" || true
    createobj "rq.yaml"
    createobj "redis-config-cm.yaml"
    createobj "redis-secret.yaml"
    createobj "redis-deploy.yaml"
    createobj "fe-deploy.yaml"
    createobj "be-deploy.yaml"
    ;;

  "destroy")
    deleteobj "be-deploy.yaml"
    deleteobj "fe-deploy.yaml"
    deleteobj "redis-deploy.yaml"
    createobj "redis-secret.yaml"
    createobj "redis-config-cm.yaml"
    deleteobj "rq.yaml"
    # "${BIN_KUBECTL}" delete namespace "${K_NS}"
    ;;
  *)
    echo "options are nscreate,deploy, destroy"
    ;;
        
esac
