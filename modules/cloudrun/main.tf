resource "google_cloud_run_service" "demo_portal" {
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    spec {
      containers {
        image = var.image_url
        ports {
          container_port = 8080
        }
        env {
          name  = "ENVIRONMENT"
          value = var.environment
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow unauthenticated invocations.
resource "google_cloud_run_service_iam_member" "noauth" {
  service = google_cloud_run_service.demo_portal.name
  location = google_cloud_run_service.demo_portal.location
  project  = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}
