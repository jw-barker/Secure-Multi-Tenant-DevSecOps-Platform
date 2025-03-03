variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR range of the subnet."
  type        = string
}

variable "region" {
  description = "The GCP region."
  type        = string
  default     = "australia-southeast1"
}
