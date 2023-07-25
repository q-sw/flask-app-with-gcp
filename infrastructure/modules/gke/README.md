# Module gke
> Readme generate by terraform-docs
## Update the documentation


```bash
terraform-docs md tbl --output-file README.md  --output-mode inject .
```



<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster) | resource |
| [google_container_node_pool.node_pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | n/a | `any` | n/a | yes |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | n/a | `any` | n/a | yes |
| <a name="input_gke_endpoint_allowed_cidrs"></a> [gke\_endpoint\_allowed\_cidrs](#input\_gke\_endpoint\_allowed\_cidrs) | n/a | `map(string)` | n/a | yes |
| <a name="input_gke_kms_key_name"></a> [gke\_kms\_key\_name](#input\_gke\_kms\_key\_name) | n/a | `any` | n/a | yes |
| <a name="input_k8s_pod_cidr"></a> [k8s\_pod\_cidr](#input\_k8s\_pod\_cidr) | n/a | `string` | `"10.1.0.0/16"` | no |
| <a name="input_k8s_services_cidr"></a> [k8s\_services\_cidr](#input\_k8s\_services\_cidr) | n/a | `string` | `"10.2.0.0/16"` | no |
| <a name="input_master_cidr_block"></a> [master\_cidr\_block](#input\_master\_cidr\_block) | n/a | `string` | `"172.16.0.0/28"` | no |
| <a name="input_node_pool_count"></a> [node\_pool\_count](#input\_node\_pool\_count) | n/a | `number` | `1` | no |
| <a name="input_node_pool_machine_type"></a> [node\_pool\_machine\_type](#input\_node\_pool\_machine\_type) | n/a | `string` | `"e2-standard-2"` | no |
| <a name="input_node_pool_name"></a> [node\_pool\_name](#input\_node\_pool\_name) | n/a | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `any` | n/a | yes |
| <a name="input_subnetwork_id"></a> [subnetwork\_id](#input\_subnetwork\_id) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->