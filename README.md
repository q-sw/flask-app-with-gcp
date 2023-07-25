# flask-app-with-gcp
This project contains a simple flask application deployed on GCP

## Terraform

In this project, I consider that your project already exists. So you don't find here how to deploy GCP project with Terraform.

In this project, all services use CMEK (Customer-managed encryption keys) when it is possible.  
You need to create firstly every key you want to use.
In my personal point of view, I use one Keyring per application and one specific key per service per environment.

I created one key for:
- the artifact registry
- GKE
- Cloud SQL
- Google Cloud Storage

To make easier the infrastructure management, each stack is split into a separate folder: 
- core-infra -> Network and artifact registry
- frontend -> GKE cluster
- backend -> GCS and Cloud SQL

If you want to externalize your terraform state file, you can uncomment and complete the file **backend.tf**

### Modules

|Name|Description|Link|
|----|-----------|----|
|[artifact-registry](./infrastructure/modules/artefact-registry/)|Manage registries in a GCP project| n/a |
|[GCS](./infrastructure/modules/gcs/)|Manage Google Cloud Storage Buckets and basic permissions| n/a |
|[GKE](./infrastructure/modules/gke/)|Manage GKE cluster and node pools| n/a|
|[Network](./infrastructure/modules/network/)| Manage Network, fork of the official Network module |[terraform-google-network](https://github.com/terraform-google-modules/terraform-google-network)|
|[SQL](./infrastructure/modules/sql/)|Manage Cloud SQL Instance, database and DB Users| n/a |