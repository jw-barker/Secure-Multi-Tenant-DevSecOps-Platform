resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  initial_node_count = var.initial_node_count

  # Enable private nodes (recommended for secure deployments)
  private_cluster_config {
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr
  }

  # Configure network settings using your previously created VPC, if desired
  network    = var.network
  subnetwork = var.subnetwork

  # Add additional security configuration as needed (e.g., network policies)
  remove_default_node_pool = true
}

# Create a separate node pool with your desired settings.
resource "google_container_node_pool" "primary_nodes" {
  name       = var.node_pool_name
  cluster    = google_container_cluster.primary.name
  location   = var.region
  project    = var.project_id

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    # Optional: enable shielding and other security settings
  }

  initial_node_count = var.initial_node_count
}
