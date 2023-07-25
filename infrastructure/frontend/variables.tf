
variable "project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "default_region" {
  type        = string
  description = "The GCP region name"
}

variable "cluster_name" {
  type        = string
  description = "The GKE cluster name"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where deploy the cluster"
}

variable "subnetwork_id" {
  type        = string
  description = "The subnetwork ID where deplo the cluster"

}

variable "cluster_secondary_subnet_name" {
  type        = string
  description = "The name of the secondary subnet to used for the Kubernetes pod network"
}

variable "services_secondary_subnet_name" {
  type        = string
  description = "The name of the secondary subnet to used for the Kubernetes service network"
}


variable "gke_kms_key_name" {
  type        = string
  description = "The URI of the Cloud KMS key "
}

variable "gke_endpoint_allowed_cidrs" {
  type        = map(string)
  description = "The list of networks allowed to connect on the k8S API"
}

variable "node_pool_name" {
  type        = string
  description = "The name of the node"
}
