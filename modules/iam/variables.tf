variable "project_id" {
  description = "The GCP project ID where the custom role, service account and bucket IAM policies will be created."
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
  description = "The display name for the service account."
  type        = string
}

variable "bucket_name" {
  description = "The name of the Storage Bucket to apply IAM policies for (e.g., remote state bucket)."
  type        = string
}
