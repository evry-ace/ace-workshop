resource "kubernetes_service_account" "tiller_sa" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller_sa" {
  metadata {
    name = kubernetes_service_account.tiller_sa.metadata[0].name
  }

  subject {
    kind      = "User"
    name      = "system:serviceaccount:kube-system:tiller"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "Group"
    name      = "system:masters"
    api_group = "rbac.authorization.k8s.io"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
}
