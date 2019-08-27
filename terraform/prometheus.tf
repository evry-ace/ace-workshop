resource "helm_release" "prometheus-operator" {
  name         = "prometheus-operator"
  chart        = "stable/prometheus-operator"
  version      = "6.7.3"
  namespace    = "monitoring"

  values = [
    <<EOF
global:
  rbac:
    enabled: true
prometheusOperator:
  cleanupCustomResourceBeforeInstall: false
  createCustomResource: false
commonLabels:
  prometheus: default
prometheus:
  prometheusSpec:
    externalUrl: http://promethues.${var.aks_ingress_dns_name}
    serviceMonitorSelector:
      matchExpressions:
        - {key: prometheus, operator: In, values: [default]}
grafana:
  enabled: true

  rbac:
    create: true

  adminUser: admin
  adminPassword: admin

  ingress:
    enabled: true

    path: "/*"
    hosts:
    - grafana.${var.aks_ingress_dns_name}

kubeScheduler:
  enabled: false
kubeApi:
  enabled: false
kubelet:
  serviceMonitor:
    https: false
kubeControllerManager:
  enabled: false
kubeEtcd:
  enabled: false
EOF
  ]
}
