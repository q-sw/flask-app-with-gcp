variable "project_id" {

}
variable "cluster_name" {

}

variable "vpc_id" {

}

variable "subnetwork_id" {

}

variable "default_region" {

}

variable "master_cidr_block" {
  default = "172.16.0.0/28"
}

variable "gke_kms_key_name" {

}

variable "gke_endpoint_allowed_cidrs" {
  type = map(string)
}


variable "cluster_secondary_subnet_name" {
  
}

variable "services_secondary_subnet_name" {
  
}
variable "node_pool_name" {

}

variable "node_pool_count" {
  default = 1
}

variable "node_pool_machine_type" {
  default = "e2-standard-2"
}


