resource "google_container_cluster" "cluster" {

  project                  = var.project_id
  name                     = var.cluster_name
  remove_default_node_pool = true
  network                  = var.vpc_id
  subnetwork               = var.subnetwork_id
  location                 = var.default_region
  initial_node_count       = 1

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_global_access_config {
      enabled = false
    }

    master_ipv4_cidr_block = var.master_cidr_block
  }

  # Configuration of etcd encryption
  database_encryption {
    state    = "ENCRYPTED"
    key_name = var.gke_kms_key_name
  }

  # Configuration of the initial node pool
  node_config {
    boot_disk_kms_key = var.gke_kms_key_name
  }


  master_authorized_networks_config {

    dynamic "cidr_blocks" {
      for_each = var.gke_endpoint_allowed_cidrs
      content {
        cidr_block   = cidr_blocks.value
        display_name = cidr_blocks.key
      }
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name = var.cluster_secondary_subnet_name
    services_secondary_range_name = var.services_secondary_subnet_name
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # addons_config {
  #   config_connector_config {
  #     enabled = true
  #   }

  #   gke_backup_agent_config {
  #     enabled = true
  #   }
  # }
}

resource "google_container_node_pool" "node_pool" {
  name     = var.node_pool_name
  location = var.default_region
  project  = var.project_id
  cluster  = google_container_cluster.cluster.id

  node_count = var.node_pool_count

  node_config {
    machine_type = var.node_pool_machine_type
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    boot_disk_kms_key = var.gke_kms_key_name
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  autoscaling {
    min_node_count  = 1
    max_node_count  = 3
    location_policy = "BALANCED"
  }
}

# resource "google_gke_backup_backup_plan" "backup" {
# 
#   name = var.backup_plan_name
#   cluster = google_container_cluster.cluster.id
#   location = var.region
#   backup_config {
#     include_volume_data = false
#     include_secrets = false
#     all_namespaces = true
#   }
#   retention_policy {
#     backup_retain_days = 7
#   }
#   backup_schedule {
#     cron_schedule = "0 * * * *"
#   }
# }
