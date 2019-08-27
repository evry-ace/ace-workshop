# ACE Workshop 2019

> ACE the hard way!

* [Lab 1: Command Line](#lab-1-command-line)
* [Lab 2: Git and GitHub](#lab-2-git-and-github)
* [Lab 3: Setting up Terraform](#lab-3-setting-up-terraform)
* [Lab 4: Setting up AKS](#lab-4-setting-up-aks)

## Lab 1: Command Line

Download and install the following tools:

* [Git](https://git-scm.com/downloads) (GitBash if you are on Windows)

Run the following command to verify that `git` is working:

```
git --version
```

* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

Run the following command to login in using you `@evry.com` account:

```
az login
az account set -s f18e2af9-2f65-4e18-bc39-54d74e271e7c
```

* [Kubernetes CLI](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

Run the following command to verify that `kubectl` is working:

```
kubectl version
```

* [Helm CLI](https://github.com/helm/helm/releases/tag/v2.14.3)
* [Terraform CLI](https://www.terraform.io/downloads.html)

> **NB!** Make sure you have at least version `v0.12.6` installed.

```
terraform --version
```

## Lab 2: Git and GitHub

* Create a new local git repository on your machine (`git init`)
* Add the following to your `.gitignore` file:

```
.env
.terraform
*.tfstate*
```

* Commit your `.gitignore` file (`git add .gitignore; git commit`)
* Add your assigned remote (`git remote add origin master git@github.com...`)
* Push your branch to the remote (`git push -u origin master`)

Move the `.conf` file you have recieved to the git repository and rename it to
`.env`. You can source the file by running the following command:

```
source .env
```

**Pro tip!** Add the terraform syntax highlighter for your favorite editor!

## Lab 3: Setting up Terraform

**NB!** In order to complete this lab you will need a `.env` file with your
assigned Azure credentials! If you have not yet got it, please ask your
instructor.

In order to get started with Terraform we need the following parts:

* One or more [Terraform providers][tf-providers]. For this workshop we will be
  using the [`azurerm`][tf-azurerm] provider.
* A [remote state backend][tf-backends] for storing the Terraform state.
* [Resources][tf-resources] (the items) that Terraform should set up.

[tf-providers]: https://terraform.io/docs/providers
[tf-backends]: https://www.terraform.io/docs/backends/index.html
[tf-azurerm]: https://www.terraform.io/docs/providers/azurerm/
[tf-azurerm-backend]: https://www.terraform.io/docs/backends/types/azurerm.html<Paste>
[tf-resources]: https://www.terraform.io/docs/configuration/resources.html

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

### variables.tf

This file will hold our [Terraform variables][tf-variables]. As the name
suggests these can be re-used accross the Terraform setup and they can have
different values for different environments.

All variables needs to be declared and we recommend that you put them in this
file in order to keep track of them an better re-usability.

> *NB!* Terraform favours underscore `_` when seperating words in variables like
> this: `my_awesome_variable`. Try to adheare to this to make the code more
> uniform.

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

Go ahead and add the following variables to your `variables.tf` file now:

```hcl
variable "user_id" {}
variable "azure_location" {}
variable "azure_resource_group" {}
variable "azure_client_id" {}
variable "azure_client_secret" {}
variable "azure_tenant_id" {}
variable "azure_subscription_id" {}
```

As you can see they have no default value. That is becuase we never want to hard
code credentials or other sensitive information inside our configuration, these
should be kept secret and injected using [environment variables][tf-envvars].

[tf-envvars]: https://www.terraform.io/docs/configuration/variables.html#environment-variables

### provider.tf

As mentioned we will be using the [`azurerm`][tf-azurerm] Terrafrom provider for
this workshop. The provider configuration connects to the infrastructure and
makes it possible for Terraform to set up, modify and delete resources on your
behalf.

The provider defintion looks like this:

```hcl
provider "azurerm" {
  subscription_id            = "${var.azure_subscription_id}"
  client_id                  = "${var.azure_client_id}"
  client_secret              = "${var.azure_client_secret}"
  tenant_id                  = "${var.azure_tenant_id}"
  version                    = "v1.33.0"
  skip_provider_registration = true
}
```

In order for Terraform to remember what had already been set up you need to set
up the remote state backend. This is using a storage account on Azure and it is
defined like this in the `provider.tf` file:

```
terraform {
  backend "azurerm" {
    container_name = "terraform-state"
    key            = "terraform.tfstate"
  }
}
```

Once all of this is set up you can initiate Terraform using the following
command:

```bash
terraform init -reconfigure \
  -backend-config="access_key=$TF_VAR_storage_access_key" \
  -backend-config="storage_account_name=$TF_VAR_storage_account_name"
```

> **NB!** If this command fails, be sure you have run `source .env`

As you can see this corresponds to the variables we have set up on our
`variables.tf` file.

### main.tf

Now let's add something to our `main.tf` file so we can verify that our setup is
working.

```hcl
data "azurerm_resource_group" "ws" {
  name = var.azure_resource_group
}
```

This won't actually create something, this is a [Terraform data
source][tf-datasources] definition which is a reference to an existing resource.

[tf-datasources]: https://www.terraform.io/docs/configuration/data-sources.html

### Verify and Apply

Once you have this working you can verify your setup by running the following
commands:

```
terraform fmt
terraform verify
```

In order to actually run this and see what it does you can run the following
commands:

```
terraform plan
terraform apply
```

This should give an output like this:

```
...
```

## Lab 4: Setting up AKS

See `main.tf` for how to set up AKS and ACR.

In order to get the credentials run the following command:

```
az aks get-credentials \
	--resource-group $TF_VAR_azure_resource_group \
	--name aks-ace \
	--file - > ~/.kube/config
```

If you get any problems try the following:

* Make sure you have sourced your `.env` file (`source .env`)

Now you can list all the [pods in your cluster][k8s-pods] by running the
following command:

```
kubectl get pods --all-namespaces
```

[k8s-pods]: https://kubernetes.io/docs/concepts/workloads/pods/pod/

## Lab 5: Set up Ingress Controller

* https://helm.sh/
* https://traefik.io/
* https://hub.kubeapps.com/charts/stable/traefik

```
resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = "kube-system"
  repository = "${data.helm_repository.stable.metadata.0.name}"
  chart      = "traefik"
  version    = "1.76.1"

  values = [<<EOF
  ...
EOF
  ]
}
```

While this is deploying run the following commands in order to follow the
progress:

```
kubectl get pods --all-namespaces --watch
```

## Lab 6: Deploy a simple application

This lab your will learn to build and deploy a simple, multi-tier web
application using Kubernetes and Docker. This example consists of the following
components:

* A single-instance Redis master to store guestbook entries
* Multiple replicated Redis instances to serve reads
* Multiple web frontend instances

* https://kubernetes.io/docs/tutorials/stateless-application/guestbook/

### Ingress Configuration

Now, create an ingress configrutaion for your guest book such that you can visit
it over the DNS and Ingress Controller that we have set up in previous labs.

* https://kubernetes.io/docs/concepts/services-networking/ingress/

The DNS name for the ingress configuration is found in your `.env` file. Add a
prefix like `guestbook.` to your `$TF_VAR_aks_ingress_dns_name` variable.

### Helm Packaging

Now we can create a Helm Chart for our guestbook application in order to get it
deployed via our Terraform setup.

* https://helm.sh/docs/developing_charts/#charts

Run the following command to create a new Helm Chart from the root of your git
repository:

```
helm create guestbook-chart
```

This creates a new directory explore what is in it before moving on. You now
need to take the Kubernetes configuration files and add them to the
`./templates` directory.

Run the following command to install the new Helm Chart:

```
helm install \
  --set ingress.hostName=guestbook.<YOU ID HERE>.workshop-2019.ace.evry.services \
  --name guestbook \
  ./guestbook-chart
```

## Lab 7: Automaion with Jenkins


## Lab 5: Build and deploy a simple application

`TBA`

## Lab 6: Set up cert-manager

`TBA`

## Lab 7: Set up Prometheus and Grafana

### Install OLM (Operator Lifecycle Manager)

Meet https://operatorhub.io/

```
kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/crds.yaml

kubectl apply -f https://github.com/operator-framework/operator-lifecycle-manager/releases/download/0.11.0/olm.yaml

kubectl apply -f manifests/prometheus-operator.yaml
kubectl apply -f manifests/prometheus-cr.yaml

kubectl apply -f manifests/grafana-operator.yaml
kubectl apply -f manifests/grafana-cr.yaml
kubectl apply -f manifests/grafana-default-dashboards.yaml
```

## Lab 8: Set up Istio (bonus)

`TBA`
