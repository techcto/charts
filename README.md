# Quick Start Guide

Run these commands to install the Solodev DXC Helm charts on your Kubernetes cluster.

```console
helm repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
helm repo update
helm repo list
```

Install the Solodev network
```console
kubectl create namespace solodev-network
helm install --namespace solodev-network --name solodev-network charts/solodev-network --set dns.zone.name=domain.com --set dns.zone.id=Z123456789
```

AWS Customers: Run this command to deploy Solodev DCX on your Kubernetes cluster.

```console
helm install --namespace solodev-dcx --name solodev1 charts/solodev-dcx-aws
```

Developers: Run this command to deploy Solodev DCX on your Kubernetes cluster.

```console
helm install --namespace solodev-dcx --name solodev1 charts/solodev-dcx
```
