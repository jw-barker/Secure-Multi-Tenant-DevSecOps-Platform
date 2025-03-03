output "grafana_url" {
  description = "Grafana release notes, including the URL"
  value       = helm_release.grafana.info.notes
}
