#!/bin/sh
set -eux
K_NS=default
NAME_PREFIX=temp-
NGINX_POD_NAME=nginx

set +eu
BIN_KUBECTL="$(which kubectl)"
[ -z "${BIN_KUBECTL}" ] && echo "ERR: NO KUBECTL FOUND" && exit 1
printf 'FOUND KUBECTL: %s\n' "${BIN_KUBECTL}"
BIN_CURL="$(which curl)"
[ -z "${BIN_CURL}" ] && echo "ERR: NO CURL FOUND" && exit 1
printf 'FOUND CURL: %s\n' "${BIN_CURL}"
EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu

case "$EXT_PARAM" in
  "podcreate")
    "${BIN_KUBECTL}" run "${NAME_PREFIX}${NGINX_POD_NAME}" --image=nginx -n "${K_NS}"  --restart=Never
    ;;

  "podview")
    "${BIN_KUBECTL}" get pod -n "${K_NS}" "${NAME_PREFIX}${NGINX_POD_NAME}"
    ;;

  "deploymentcreate")
    "${BIN_KUBECTL}" create deployment -n "${K_NS}" "${NAME_PREFIX}${NGINX_POD_NAME}" --image=nginx
    ;;

  "deploymentport")
    POD_PF=$(${BIN_KUBECTL} get pods -n "${K_NS}" --selector=app="${NAME_PREFIX}${NGINX_POD_NAME}" -oname|sed 's,pod/,,'|head -n1)
    [ -z "${POD_PF}" ] && printf 'ERR: Couldnt find pods for deployment: %s' "${NAME_PREFIX}${NGINX_POD_NAME}" && exit 1
    "${BIN_KUBECTL}" port-forward -n "${K_NS}" "$POD_PF" 8080:80 &
    PF_PID=$!
    sleep 5s
    curl -L "http://localhost:8080" || exit 0
    kill "${PF_PID}"
    ;;

  "destroy")
    "${BIN_KUBECTL}" -n "${K_NS}" delete pod "${NAME_PREFIX}${NGINX_POD_NAME}"
    "${BIN_KUBECTL}" delete deployment -n "${K_NS}" "${NAME_PREFIX}${NGINX_POD_NAME}" 
    ;;
  *)
    echo "default just bulding"
    ;;
        
esac
