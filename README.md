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

Terraform syntax highlighter for your favorite editor!

## Lab 3: Set up AKS cluster with Terraform

In order to get started with Terraform we need the following parts:

* One ore more [Terraform providers][tf-providers]. For this workshop we will be
  using the [`azurerm`][tf-azurerm] provider.
* A [remote state backend][tf-backends] for storing the Terraform state.

[tf-providers]: https://terraform.io/docs/providers
[tf-backends]: https://www.terraform.io/docs/backends/index.html
[tf-azurerm]: https://www.terraform.io/docs/providers/azurerm/
[tf-azurerm-backend]: https://www.terraform.io/docs/backends/types/azurerm.html<Paste>

### Directory structure

Terraform is very relax when it comes to file structure. It dosn't require any
main methods or file conventions as it creates a depencendy graph dynamically.
However it requires all files to be at the root folder (unless you are using
modules).

Start by create a folder named `terraform` in your git repo; inside this the
following files should be present. Just create empty files and we'll fill them
with content as we go.

* `variables.tf`
* `provider.tf`
* `main.tf`

#### variables.tf

This file will hold our [Terraform variables][tf-variables]. As the name
suggests these can be re-used accross the Terraform setup and they can have
different values for different environments.

All variables needs to be declared and we recommend that you put them in this
file in order to keep track of them an better re-usability.

*NB!* Terraform favours underscore `_` when seperating words in variables like
this: `my_awesome_variable`. Try to adheare to this to make the code more
uniform.

Variables are declared like this:

```hcl
variable "my_variable" {}
```

This will create an unitialized variable which means that you need to assign it
a value at runtime in order for Terraform to procede.

If you want to hava a default value you can do it like this:

```hcl
value "my_variable" {
  default = "This is a default value"
}
```

Variables are strings by default but Terraform supports a variety of other [data
types][tf-datatypes].

[tf-variables]: https://www.terraform.io/docs/configuration/variables.html
[tf-datatypes]: https://www.terraform.io/docs/configuration/types.html

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

kubectl apply -f manifests/grafana-operator.yaml
kubectl apply -f manifests/grafana-cr.yaml
kubectl apply -f manifests/grafana-default-dashboards.yaml

## Lab 8: Set up Istio (bonus)

`TBA`
