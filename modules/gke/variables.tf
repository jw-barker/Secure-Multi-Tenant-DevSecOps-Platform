variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
}

variable "initial_node_count" {
  description = "Initial number of nodes in the cluster/node pool."
  type        = number
  default     = 1
}

variable "master_ipv4_cidr" {
  description = "The IPv4 CIDR block for the cluster master."
  type        = string
  default     = "172.16.0.0/28"
}

variable "cluster_secondary_range_name" {
  description = "The name of the secondary IP range for pods in the cluster (if applicable)."
  type        = string
  default     = ""  # Set this if you have created a secondary range.
}

variable "services_secondary_range_name" {
  description = "The name of the secondary IP range for services in the cluster (if applicable)."
  type        = string
  default     = ""  # Set this if you have created a secondary range.
}

variable "master_authorized_cidr" {
  description = "The CIDR block allowed to access the cluster master."
  type        = string
  default     = "203.0.113.0/24"  # Replace with a secure, authorized range.
}

variable "master_authorized_display_name" {
  description = "Display name for the authorized master network."
  type        = string
  default     = "admin-office"
}

variable "environment" {
  description = "Environment label (e.g., 'dev', 'prod')."
  type        = string
  default     = "dev"
}

variable "network" {
  description = "The name or self_link of the VPC network to use."
  type        = string
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork to use."
  type        = string
}

variable "node_pool_name" {
  description = "The name for the node pool."
  type        = string
  default     = "primary-node-pool"
}

variable "machine_type" {
  description = "The machine type for cluster nodes."
  type        = string
  default     = "e2-medium"
}

variable "node_pool_service_account" {
  description = "Custom service account for the node pool. Leave empty to use the default service account."
  type        = string
  default     = ""
}
