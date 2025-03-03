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