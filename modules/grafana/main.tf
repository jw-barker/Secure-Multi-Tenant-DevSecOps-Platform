provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "grafana" {
  name             = var.service_name
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version

  set {
    name  = "service.type"
    value = var.service_type
  }

  set {
    name  = "adminPassword"
    value = var.admin_password
  }
}
