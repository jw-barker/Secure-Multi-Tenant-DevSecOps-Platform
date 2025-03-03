variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
  default     = "us-central1"
}

variable "tenant" {
  description = "Tenant identifier to generate unique service account names."
  type        = string
}

variable "sa_display_name" {
  description = "The display name for the new service account."
  type        = string
}
