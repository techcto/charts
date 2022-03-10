#!/bin/bash
args=("$@")

tag(){
    VERSION="${args[1]}"
    git tag -a v${VERSION} -m "tag release"
    git push --tags
}

update(){
    helm package ocoa-core
    helm package apistudio
    helm package solodev-network
    helm package solodev-cms
    helm package solodev-cron
    helm package wordpress
    helm package lets-encrypt
    helm package dashboard
    helm repo index .
    helm repo update
}

$*