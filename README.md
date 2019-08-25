# ACE Workshop 2019

Template for ACE Workshop

## Lab 1: Command Line

Download and install the following tools:

* [Git](https://git-scm.com/downloads) (GitBash if you are on Windows)

Run the following command to verify that `git` is working:

```
git --version
```

Then [clone this repository](https://help.github.com/en/articles/cloning-a-repository).

* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

Run the following command to login in using you `@evry.com` account:

```
az login
```

* [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Run the following command to verify that `kubectl` is working:

```
kubectl --version
```

* [Helm CLI](https://github.com/helm/helm/releases/tag/v2.14.3)
* [Terraform CLI](https://www.terraform.io/downloads.html)

## Lab 2: Git and GitHub

`TBA`

## Lab 3: Set up AKS cluster with Terraform

`TBA`

## Lab 4: Set up Ingress Controller

`TBA`

## Lab 5: Build and deploy a simple application

`TBA`

## Lab 6: Set up cert-manager

`TBA`

## Lab 7: Set up Prometheus and Grafana

### Install OLM (Operator Lifecycle Manager)

Meet https://operatorhub.io/

kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/crds.yaml
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/olm.yaml

kubectl apply -f manifests/prometheus-operator.yaml
kubectl apply -f manifests/prometheus-cr.yaml

## Lab 8: Set up Istio (bonus)

`TBA`
