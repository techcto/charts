#!/bin/bash

# export $(egrep -v '^#' .env | xargs)
args=("$@")

tag(){
    VERSION="${args[1]}"
    git tag -a v${VERSION} -m "tag release"
    git push --tags
}

update(){
    helm package solodev-network
    helm package solodev-dcx
    helm package vortala-solodev
    helm repo index .
    helm repo update
}

$*