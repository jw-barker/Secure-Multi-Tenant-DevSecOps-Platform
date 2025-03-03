variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The region for Cloud Run."
  type        = string
  default     = "australia-southeast1"
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}

variable "image_url" {
  description = "The container image URL to deploy."
  type        = string
}

variable "environment" {
  description = "An environment label"
  type        = string
  default     = "dev"
}
