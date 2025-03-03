output "grafana_url" {
  description = "The URL of the deployed Grafana service."
  value       = helm_release.grafana.status[0].url
}
