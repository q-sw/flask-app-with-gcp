# flask-app-with-gcp
This project contains a simple flask application deployed on GCP

## How to use

To facilitate the project usage and deployment, you can use a set of make tasks.  
Show the description below:

|Category|Tasks name|Description|
|--------|----------|-----------|
|Docker|build-docker-image|Build locally the docker image|
|Docker|build-and-push-image|Build and push the docker image in the registry|
|Docker|run-app-locally|Run the docker application locally|
|Docker|remove-app-locally|Remove the existing docker container|
|Terraform|tf-prebuild-xxxx|Run terraform init, validate and fmt on the specific infrastructure stage|
|Terraform|tf-plan-xxxx|Run terraform plan on the specific infrastructure stage. It generate a plan file|
|Terraform|tf-apply-xxxx|Run terraform apply on the specific infrastructure stage based on the plan file generated previously|
|Terraform|tf-destroy-xxxx|Run terraform destroy on the specific infrastructure stage based on the plan file generated previously|
|Terraform-module|tf-module-update-readme|Update the module readme for each module(execpte network)|
|Terraform-module|tf-module-fmt|Format all terraform files|
|kubernetes|k8s-deploy|Deploy the application on Kubernetes cluster|
|kubernetes|k8s-port-forward|Access locally to the application deploy on the cluster on port 80|
|kubernetes|k8s-delete-deploy-dev|Delete the application from the Kubernetes cluster|

For the terraform command you can replace **"xxxx"** by:
- core-infra
- frontend
- backend

### Prerequisites:

- Docker
- Python 3.11
- Terraform
- Gcloud CLI
- kubectl
- GCP project with an associate billing account
- One or more Cloud KMS keys (CMEK)

### Terraform Service Account permissions

***Ongoing***

### Personalize your deployment

For each infrastructure stage, you can find a **terraform.example.tfvars** that you can complete and use to deploy the infrastructure
To customize the Kubernetes deployment you can modify the [kustomization.yaml](./k8s-manifests/kustomization.yaml) file.  
Replace all xxx with your values.

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