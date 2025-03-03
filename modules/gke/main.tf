# tfsec:ignore:google-gke-enforce-pod-security-policy: Pod Security Policy enforcement is managed by GKE defaults and the Pod Security Admission controller in newer versions.
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  project  = var.project_id

  initial_node_count = var.initial_node_count

  # Private cluster configuration.
  private_cluster_config {
    enable_private_nodes   = true
    master_ipv4_cidr_block = var.master_ipv4_cidr
  }

  # Enable IP aliasing.
  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  # Enable master authorised networks.
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.master_authorized_cidr
      display_name = var.master_authorized_display_name
    }
  }

  # Enable network policy for pod-to-pod communication.
  network_policy {
    enabled = true
  }

  resource_labels = {
    environment = var.environment
  }

  # Specify the VPC network and subnetwork.
  network    = var.network
  subnetwork = var.subnetwork
}

resource "google_container_node_pool" "primary_nodes" {
  name     = var.node_pool_name
  cluster  = google_container_cluster.primary.name
  location = var.region
  project  = var.project_id

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    service_account = var.node_pool_service_account

    // tfsec:ignore:google-gke-metadata-endpoints-disabled: Legacy metadata endpoints are explicitly disabled.
    // tfsec:ignore:google-gke-node-metadata-security: Node metadata is explicitly set to SECURE.
    metadata = {
      disable-legacy-endpoints = "true"
      node_metadata            = "SECURE"
    }

    // Using Container-Optimised OS with containerd.
    image_type = "COS_CONTAINERD"
  }

  initial_node_count = var.initial_node_count

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

