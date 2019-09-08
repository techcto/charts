#!/bin/bash

export $(egrep -v '^#' .env | xargs)
args=("$@")

tag(){
    VERSION="${args[1]}"
    git tag -a v${VERSION} -m "tag release"
    git push --tags
}

update(){
    #https://blog.softwaremill.com/hosting-helm-private-repository-from-github-ff3fa940d0b7
    helm package solodev-dcx
    helm repo index .
    helm repo update
}

addCustomCharts(){
    helm repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
    helm repo update
    helm repo list
}

$*