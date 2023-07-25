module "gke" {
  source = "../modules/gke"

  project_id                     = var.project_id
  default_region                 = var.default_region
  cluster_name                   = var.cluster_name
  vpc_id                         = var.vpc_id
  subnetwork_id                  = var.subnetwork_id
  gke_kms_key_name               = var.gke_kms_key_name
  cluster_secondary_subnet_name  = var.cluster_secondary_subnet_name
  services_secondary_subnet_name = var.services_secondary_subnet_name
  gke_endpoint_allowed_cidrs     = {}

  node_pool_name = var.node_pool_name
  depends_on     = [google_project_service.backend_project, module.network]
}
