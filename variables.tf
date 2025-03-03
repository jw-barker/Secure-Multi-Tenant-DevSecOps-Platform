variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
  default     = "australia-southeast1"
}

variable "sa_display_name" {
  description = "The display name for the new service account."
  type        = string
}

variable "environment" {
  description = "Environment label"
  type        = string
  default     = "dev"
}

variable "demo_portal_image_url" {
  description = "The URL of the demo portal container image"
  type        = string
}

variable "bucket_name" {
  description = "The name of the Storage Bucket for remote state."
  type        = string
}

variable "grafana_admin_password" {
  description = "The admin password for Grafana."
  type        = string
  sensitive   = true
}
