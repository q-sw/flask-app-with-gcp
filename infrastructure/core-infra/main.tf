resource "google_project_service" "backend_project" {
  for_each = toset(var.backend_services)
  project  = var.project_id
  service  = each.key

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = false
  disable_on_destroy         = false
}

module "artifact" {
  source = "../modules/artifact-registry"

  project_id   = var.project_id
  repositories = var.repositories
  depends_on   = [google_project_service.backend_project]
}

module "network" {
  source = "../modules/network"

  project_id   = var.project_id
  network_name = var.vpc_name
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name               = "gke-subnet"
      subnet_ip                 = "10.10.0.0/24"
      subnet_region             = var.default_region
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.5
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      subnet_private_access     = "true"
    }
  ]
  secondary_ranges = {
    gke-subnet = [
      {
        range_name    = "gke-k8s-pod-subnet"
        ip_cidr_range = "10.100.0.0/16"
      },
      {
        range_name    = "gke-k8s-services-subnet"
        ip_cidr_range = "10.120.0.0/16"
      },
    ]

  }
  depends_on = [google_project_service.backend_project]
}
