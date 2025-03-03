# Generate a random suffix for uniqueness.
resource "random_id" "sa_suffix" {
  byte_length = 2  # Produces a 4-character hex string.
}

# Create a new service account with a name formatted as "sa-<tenant>-<suffix>".
resource "google_service_account" "sa" {
  account_id   = format("sa-%s-%s", var.tenant, random_id.sa_suffix.hex)
  display_name = var.sa_display_name
}

# Create a custom IAM role in the project.
resource "google_project_iam_custom_role" "custom_role" {
  role_id     = var.role_id
  title       = var.role_title
  description = var.role_description
  project     = var.project_id
  permissions = var.permissions
}

# Bind the custom role to the newly created service account.
resource "google_service_account_iam_member" "role_binding" {
  service_account_id = google_service_account.sa.email
  role               = google_project_iam_custom_role.custom_role.name
  member             = "serviceAccount:${google_service_account.sa.email}"
}
