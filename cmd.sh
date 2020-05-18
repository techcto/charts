#!/bin/bash
args=("$@")

tag(){
    VERSION="${args[1]}"
    git tag -a v${VERSION} -m "tag release"
    git push --tags
}

update(){
    helm package solodev-network
    helm package solodev-cms
    helm package solodev-cms-aws
    helm package solodev-cron
    helm package wordpress
    helm repo index .
    helm repo update
}

$*