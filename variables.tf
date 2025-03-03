variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
  default     = "australia-southeast1"
}

variable "tenant" {
  description = "Tenant identifier to generate unique service account names."
  type        = string
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