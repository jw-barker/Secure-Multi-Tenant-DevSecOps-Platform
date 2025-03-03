terraform {
  backend "gcs" {
    bucket = "terraform-state-devsecops-8758"
    prefix = "terraform/state"
  }
}