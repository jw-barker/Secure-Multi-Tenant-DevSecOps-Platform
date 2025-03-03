terraform {
  backend "gcs" {
    bucket  = "terraform-state-jb87"
    prefix  = "terraform/state"
  }
}