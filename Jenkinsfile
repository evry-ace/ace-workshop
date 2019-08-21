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
String dockerImage = "evryace/helm-kubectl-terraform:2.14.1__1.13.5__0.12.2"

ace(opts) {
  String helmVer = "v2.14.1"
  String helmImage = "lachlanevenson/k8s-helm:${helmVer}"
  String helmArgs = ["--entrypoint=''", "-e HELM_HOME=${env.WORKSPACE}"].join(" ")

  stage('init') {
    sh "helm init --client-only"
  }
}
