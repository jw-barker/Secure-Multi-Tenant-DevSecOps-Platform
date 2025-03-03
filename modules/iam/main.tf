# Create (or manage) a fixed service account.
resource "google_service_account" "sa" {
  account_id   = "devsecops-admin"  # Fixed account ID.
  display_name = var.sa_display_name
  project      = var.project_id

  lifecycle {
    prevent_destroy = true
  }
}

# Create a custom IAM role in the project.
resource "google_project_iam_custom_role" "custom_role" {
  role_id     = var.role_id
  title       = var.role_title
  description = var.role_description
  project     = var.project_id
  permissions = var.permissions
}

# Bind the custom role to the service account.
resource "google_service_account_iam_member" "role_binding" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${google_service_account.sa.email}"
  role               = google_project_iam_custom_role.custom_role.name
  member             = "serviceAccount:${google_service_account.sa.email}"
}

# Set Storage Bucket IAM bindings.
resource "google_storage_bucket_iam_binding" "legacy_bucket_owner" {
  bucket = var.bucket_name
  role   = "roles/storage.legacyBucketOwner"
  members = [
    "projectEditor:${var.project_id}",
    "projectOwner:${var.project_id}",
  ]
}

resource "google_storage_bucket_iam_binding" "legacy_bucket_reader" {
  bucket = var.bucket_name
  role   = "roles/storage.legacyBucketReader"
  members = [
    "projectViewer:${var.project_id}",
  ]
}

resource "google_storage_bucket_iam_binding" "legacy_object_owner" {
  bucket = var.bucket_name
  role   = "roles/storage.legacyObjectOwner"
  members = [
    "projectEditor:${var.project_id}",
    "projectOwner:${var.project_id}",
  ]
}

resource "google_storage_bucket_iam_binding" "legacy_object_reader" {
  bucket = var.bucket_name
  role   = "roles/storage.legacyObjectReader"
  members = [
    "projectViewer:${var.project_id}",
  ]
}

resource "google_storage_bucket_iam_binding" "object_creator" {
  bucket = var.bucket_name
  role   = "roles/storage.objectCreator"
  members = [
    "serviceAccount:${google_service_account.sa.email}",
  ]
}
