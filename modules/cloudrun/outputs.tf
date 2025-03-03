output "cloudrun_service_url" {
  description = "The URL of the deployed Cloud Run service."
  value       = google_cloud_run_service.demo_portal.status[0].url
}
