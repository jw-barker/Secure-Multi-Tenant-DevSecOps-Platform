terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}

module "network" {
  source       = "./modules/network"
  network_name = "devsecops-vpc"
  subnet_name  = "devsecops-subnet"
  subnet_cidr  = "10.0.0.0/16"
  region       = "us-central1"
}

module "iam" {
  source           = "./modules/iam"
  project_id       = var.project_id
  tenant           = var.tenant
  role_id          = "customDevSecOpsRole"
  role_title       = "Custom DevSecOps Role"
  role_description = "Role for managing secure resources in the DevSecOps platform"
  permissions      = [
    "compute.instances.list",
    "compute.networks.get",
    "resourcemanager.projects.get"
    # Add any additional permissions as needed.
  ]
  sa_display_name  = var.sa_display_name
}

output "iam_custom_role" {
  value = module.iam.custom_role_name
}

output "service_account_email" {
  value = module.iam.service_account_email
}

module "gke" {
  source              = "./modules/gke"
  project_id          = var.project_id
  region              = var.region
  cluster_name        = "devsecops-cluster"
  initial_node_count  = 1
  master_ipv4_cidr    = "172.16.0.0/28"
  network             = module.network.network_id
  subnetwork          = module.network.subnet_id 
  node_pool_name      = "primary-node-pool"
  machine_type        = "e2-medium"
}
