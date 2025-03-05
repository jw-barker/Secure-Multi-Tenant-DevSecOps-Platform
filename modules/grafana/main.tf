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

  # Override grafana.ini settings using a values block:
  # Enable anonymous access and embedding.
  values = [
    <<EOF
grafana.ini:
  auth.anonymous:
    enabled: true
    org_role: Viewer
  security:
    allow_embedding: true
EOF
  ]

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

  # Persistence settings (disabled for this demo)
  set {
    name  = "persistence.enabled"
    value = "false"
  }
  set {
    name  = "persistence.size"
    value = "10Gi"
  }
}

data "kubernetes_service" "grafana" {
  metadata {
    name      = helm_release.grafana.name
    namespace = var.namespace
  }
}
