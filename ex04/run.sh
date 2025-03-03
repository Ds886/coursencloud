#!/bin/sh
set -eux
K_NS=ex04
printf 'K_NS: %s' "${K_NS}"

set +eu
BIN_KUBECTL="$(which kubectl)"
[ -z "${BIN_KUBECTL}" ] && echo "ERR: NO KUBECTL FOUND" && exit 1
printf 'FOUND KUBECTL: %s\n' "${BIN_KUBECTL}"
EXT_PARAM="$1"
printf 'PARAMS: %s\n' "${EXT_PARAM}"
set -eu

case "$EXT_PARAM" in
  "deploy-ingress")
    find ingress -type f -name '*.yaml' -exec kubectl apply -n "${K_NS}" -f {} \;
    ;;

  "destroy-ingress")
    find ingress  -type f -name '*.yaml' -exec kubectl delete -n "${K_NS}"  -f {} \;
    ;;

  "build-pvc")
    cd pvc/app
    pwd
    ls
    docker build -t "dash886/flasexpvc:latest" .
    docker push  "dash886/flasexpvc:latest" 
    ;;

  "deploy-pvc")
    find pvc -type f -name '*.yaml' -exec kubectl apply -n "${K_NS}" -f {} \;
    ;;

  "destroy-pvc")
    find pvc  -type f -name '*.yaml' -exec kubectl delete -n "${K_NS}"  -f {} \;
    ;;

  "deploy-sts")
    find sts -type f -name '*.yaml' -exec kubectl apply -n "${K_NS}" -f {} \;
    ;;

  "destroy-sts")
    find pvc  -type f -name '*.yaml' -exec kubectl delete -n "${K_NS}"  -f {} \;
    ;;
  "build-cjob")
    cd cjob/app
    pwd
    ls
    docker build -t "dash886/cjob:1.0.0" .
    docker push  "dash886/cjob:1.0.0" 
    ;;

  "deploy-cjob")
    find cjob -type f -name '*.yaml' -exec kubectl apply -n "${K_NS}" -f {} \;
    ;;

  "destroy-cjob")
    find cjob  -type f -name '*.yaml' -exec kubectl delete -n "${K_NS}"  -f {} \;
    ;;
  *)
    echo "default just bulding"
    ;;
        
esac
