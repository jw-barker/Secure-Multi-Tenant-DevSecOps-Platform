output "grafana_url" {
  description = "The external URL of the Grafana service."
  value = coalesce(
    lookup(element(data.kubernetes_service.grafana.status.load_balancer.ingress, 0), "ip", null),
    lookup(element(data.kubernetes_service.grafana.status.load_balancer.ingress, 0), "hostname", null)
  )
}
