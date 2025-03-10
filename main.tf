terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.18.1"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.cluster_endpoint}"
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

module "network" {
  source       = "./modules/network"
  network_name = "devsecops-vpc"
  subnet_name  = "devsecops-subnet"
  subnet_cidr  = "10.0.0.0/16"
  region       = var.region
}

module "iam" {
  source           = "./modules/iam"
  project_id       = var.project_id
  role_id          = "customDevSecOpsRole"
  role_title       = "Custom DevSecOps Role"
  role_description = "Role for managing secure resources in the DevSecOps platform"
  permissions = [
    "compute.instances.list",
    "compute.networks.get",
    "resourcemanager.projects.get"
    # Add any additional permissions as needed.
  ]
  sa_display_name = var.sa_display_name
  bucket_name     = var.bucket_name
}

module "gke" {
  source                         = "./modules/gke"
  project_id                     = var.project_id
  region                         = var.region
  cluster_name                   = "devsecops-cluster"
  initial_node_count             = 1
  master_ipv4_cidr               = "172.16.0.0/28"
  master_authorized_cidr         = "0.0.0.0/0"
  master_authorized_display_name = "admin-office"
  environment                    = "dev"
  network                        = module.network.network_id
  subnetwork                     = module.network.subnet_id
  node_pool_name                 = "primary-node-pool"
  machine_type                   = "e2-medium"
  node_pool_service_account      = ""
}

module "demo_portal" {
  source       = "./modules/cloudrun"
  project_id   = var.project_id
  region       = var.region
  service_name = "demo-portal"
  image_url    = var.demo_portal_image_url
  environment  = var.environment
}

module "grafana" {
  source         = "./modules/grafana"
  project_id     = var.project_id
  region         = var.region
  service_name   = "grafana"
  namespace      = "monitoring"
  chart_version  = "6.17.4"
  service_type   = "LoadBalancer"
  admin_password = var.grafana_admin_password

  providers = {
    helm = helm
  }
}
