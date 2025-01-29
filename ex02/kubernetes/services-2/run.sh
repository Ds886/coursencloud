#!/bin/sh
find . -iname '*.yaml' -exec kubectl apply -f {} \;
