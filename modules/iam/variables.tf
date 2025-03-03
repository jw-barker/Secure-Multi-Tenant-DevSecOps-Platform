variable "project_id" {
  description = "The GCP project ID where the custom role and service account will be created."
  type        = string
}

variable "tenant" {
  description = "A tenant identifier to include in the service account name."
  type        = string
}

variable "role_id" {
  description = "The ID for the custom IAM role."
  type        = string
}

variable "role_title" {
  description = "The title of the custom IAM role."
  type        = string
}

variable "role_description" {
  description = "A description of what the custom IAM role does."
  type        = string
}

variable "permissions" {
  description = "A list of permissions to assign to the custom role."
  type        = list(string)
}

variable "sa_display_name" {
  description = "The display name for the new service account."
  type        = string
}
