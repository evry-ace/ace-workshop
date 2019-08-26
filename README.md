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
kubectl version
```

* [Helm CLI](https://github.com/helm/helm/releases/tag/v2.14.3)
* [Terraform CLI](https://www.terraform.io/downloads.html)

**NB!** Make sure you have at least version `v0.12.6` installed.

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

## Lab 3: Set up AKS cluster with Terraform

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
terraformorm init \
  -backend-config="access_key=$TF_VAR_storage_account_name" \
  -backend-config="storage_account_name=$TF_VAR_storage_access_key" \
```

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

Once you have this working you can verify your setup


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
