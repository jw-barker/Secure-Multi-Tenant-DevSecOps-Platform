output "custom_role_name" {
  description = "The full name of the custom IAM role."
  value       = google_project_iam_custom_role.custom_role.name
}

output "service_account_email" {
  description = "The email of the newly created service account."
  value       = google_service_account.sa.email
}
