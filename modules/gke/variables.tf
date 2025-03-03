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
