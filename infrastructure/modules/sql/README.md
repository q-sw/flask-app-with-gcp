# Module sql
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
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 4.70.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.70.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 4.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google-beta/4.70.0/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_project_service_identity.sql](https://registry.terraform.io/providers/hashicorp/google-beta/4.70.0/docs/resources/google_project_service_identity) | resource |
| [google-beta_google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google-beta/4.70.0/docs/resources/google_service_networking_connection) | resource |
| [google-beta_google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google-beta/4.70.0/docs/resources/google_sql_database_instance) | resource |
| [google_sql_database.database](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/sql_database) | resource |
| [google_sql_user.user](https://registry.terraform.io/providers/hashicorp/google/4.70.0/docs/resources/sql_user) | resource |
| [random_password.pwd](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The database name | `string` | n/a | yes |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | The database user name | `string` | n/a | yes |
| <a name="input_db_instance_size"></a> [db\_instance\_size](#input\_db\_instance\_size) | The Cloud sql instance size | `string` | n/a | yes |
| <a name="input_db_version"></a> [db\_version](#input\_db\_version) | The MySQL, PostgreSQL or SQL Server version to use | `string` | n/a | yes |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | Thes GCP region name | `string` | `"europe-west9"` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | The Kms Key Id for GCS (projects/{{project}}/locations/{{location}}/keyRings/{{keyRing}})/cryptoKeys/{{name}} | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id | `string` | n/a | yes |
| <a name="input_sql_instance_name"></a> [sql\_instance\_name](#input\_sql\_instance\_name) | The Cloud sql instance name | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | n/a |
| <a name="output_sql-password"></a> [sql-password](#output\_sql-password) | n/a |
| <a name="output_sql-user-name"></a> [sql-user-name](#output\_sql-user-name) | n/a |
<!-- END_TF_DOCS -->