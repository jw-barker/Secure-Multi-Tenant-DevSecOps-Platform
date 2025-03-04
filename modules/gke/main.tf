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

  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.master_authorized_cidr
      display_name = var.master_authorized_display_name
    }
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  release_channel {
    channel = "REGULAR"
  }

  network_policy {
    enabled = true
  }

  resource_labels = {
    environment = var.environment
  }

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
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    service_account = var.node_pool_service_account

    # Set metadata securely.
    metadata = {
      disable-legacy-endpoints = "true"
      node_metadata            = "SECURE"
    }

    image_type = "COS_CONTAINERD"

    kubelet_config {
      cpu_manager_policy = "none"
    }
    
  }

  initial_node_count = var.initial_node_count

  management {
    auto_upgrade = true
    auto_repair  = true
  }
  
}
