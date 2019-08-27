#!groovy

@Library("ace") _

import no.ace.Terraform

properties([disableConcurrentBuilds()])

Map opts = [
  agent: 'jenkins-docker-3',
  dockerSet: false,
]

Boolean isMaster = "${env.BRANCH_NAME}" == 'master'
Boolean isPR = "${env.CHANGE_URL}".contains('/pull/')

ace(opts) {
  String helmImage = "lachlanevenson/k8s-helm:v2.14.1"
  String helmArgs = ["--entrypoint=''", "-e HELM_HOME=${env.WORKSPACE}"].join(" ")

  stage('helm init') {
    docker.image(helmImage).inside(helmArgs) {
      sh "helm init --client-only"
    }
  }

  stage('terraform') {
    Map tfOpts = [
      dockerImage: 'evryace/helm-kubectl-terraform:2.14.1__1.13.7__0.12.6',
      provider: 'azure',
      path: 'terraform',
      extraCreds: [
        [id: 'azure_subscription_id'],
        [id: 'azure_tenant_id'],
        [id: 'azure_resource_group'],
        [id: 'azure_location'],
        [id: 'azure_client_id'],
        [id: 'azure_client_secret'],
        //[id: 'aks_ssh_public_key'],
        [id: 'aks_ingress_ip'],
        [id: 'aks_ingress_dns_name'],
        [id: 'aks_rbac_client_app_id'],
        [id: 'aks_rbac_server_app_id'],
        [id: 'aks_rbac_server_app_secret'],
        [id: 'aks_rbac_cluster_admins_group_id'],
        [id: 'user_id'],
      ],
    ]

    terraform('default', tfOpts) {
      lint()
      plan()
    }
  }
}
