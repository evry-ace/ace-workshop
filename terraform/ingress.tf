data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "traefik" {
  name       = "traefik"
  namespace  = "kube-system"
  repository = "${data.helm_repository.stable.metadata.0.name}"
  chart      = "traefik"
  version    = "1.76.1"

  set {
    name  = "loadBalancerIP"
    value = var.aks_ingress_ip
  }
}
