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
