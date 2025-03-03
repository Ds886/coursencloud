#!/bin/sh
set -eux
K_NS=ex04-hw
printf 'K_NS: %s' "${K_NS}"

set +eu
BIN_KUBECTL="$(which kubectl)"
[ -z "${BIN_KUBECTL}" ] && echo "ERR: NO KUBECTL FOUND" && exit 1
printf 'FOUND KUBECTL: %s\n' "${BIN_KUBECTL}"
EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu
build_image(){
    cd app
    pwd
    ls
    docker build -t "dash886/flasexpvc:latest" .
    docker push  "dash886/flasexpvc:latest" 
}
case "$EXT_PARAM" in
  "deploy")
    find k8s -type f -name '*.yaml' -exec kubectl apply -n "${K_NS}" -f {} \;
    ;;

  "destroy")
    find k8s -type f -name '*.yaml' -exec kubectl delete -n "${K_NS}"  -f {} \;
    ;;

 *)
    echo "Unknown command. Available commands: build, destroy"
    ;;
        
esac
