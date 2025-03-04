output "grafana_url" {
  description = "The external URL of the Grafana service."
  value = coalesce(
    data.kubernetes_service.grafana.status[0].load_balancer[0].ingress[0].ip,
    data.kubernetes_service.grafana.status[0].load_balancer[0].ingress[0].hostname
  )
}
