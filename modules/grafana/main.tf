terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
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

    set {
    name  = "rbac.pspEnabled"
    value = "false"
  }
  
  # Enable anonymous access
  set {
    name  = "auth.anonymous.enabled"
    value = "true"
  }
  
  set {
    name  = "auth.anonymous.org_role"
    value = "Viewer"
  }
}

data "kubernetes_service" "grafana" {
  metadata {
    name      = helm_release.grafana.name
    namespace = var.namespace
  }
}
