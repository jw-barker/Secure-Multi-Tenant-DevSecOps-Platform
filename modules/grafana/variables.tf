variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region for Grafana deployment."
  type        = string
  default     = "australia-southeast1"
}

variable "service_name" {
  description = "The name for the Grafana service."
  type        = string
  default     = "grafana"
}

variable "namespace" {
  description = "The Kubernetes namespace for Grafana."
  type        = string
  default     = "monitoring"
}

variable "chart_version" {
  description = "The version of the Grafana Helm chart."
  type        = string
  default     = "6.17.4"
}

variable "service_type" {
  description = "The type of Kubernetes service for Grafana"
  type        = string
  default     = "LoadBalancer"
}

variable "admin_password" {
  description = "The admin password for Grafana."
  type        = string
  sensitive   = true
}
