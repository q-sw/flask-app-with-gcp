# Module gcs
> Readme generate by terraform-docs

## Update the documentation

```bash
terraform-docs md tbl --output-file README.md  --output-mode inject .
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_service.project](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/project_service) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.binding_admin](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.binding_viewer](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/storage_bucket_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_admin_members"></a> [bucket\_admin\_members](#input\_bucket\_admin\_members) | The list of principal that have storage.objectAdmin permission | `list(string)` | `[]` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The GCS bucket name | `string` | n/a | yes |
| <a name="input_bucket_viewer_members"></a> [bucket\_viewer\_members](#input\_bucket\_viewer\_members) | The list of principal that have storage.objectViewer permission | `list(string)` | `[]` | no |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | The GCP region use to deploy | `string` | `"europe-west9"` | no |
| <a name="input_kms_key"></a> [kms\_key](#input\_kms\_key) | The Kms Key Id (projects/{{project}}/locations/{{location}}/keyRings/{{keyRing}})/cryptoKeys/{{name}} | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCPP project ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcs_url"></a> [gcs\_url](#output\_gcs\_url) | n/a |
<!-- END_TF_DOCS -->