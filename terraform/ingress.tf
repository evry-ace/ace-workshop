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

  values = [<<EOF
loadBalancerIP: ${var.aks_ingress_ip}
service:
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-resource-group: ${data.azurerm_resource_group.ws.name}
dashboard:
  enabled: true
  domain: traefik.${var.aks_ingress_dns_name}

rbac:
  enabled: true
EOF
  ]
}
