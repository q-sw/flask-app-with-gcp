.PHONY: build-docker-image build-and-push-image run-app-locally remove-app-locally

docker-image-name="flask-app"
docker-image-version="1.0.0"
docker-registry-name=""

# Not include network module, it's managend by google
tf-modules = artifact-registry gcs gke sql

build-infra: tf-prebuild-core-infra tf-plan-core-infra tf-apply-core-infra tf-prebuild-backend tf-plan-backend tf-apply-backend tf-prebuild-frontend tf-plan-frontend tf-apply-frontend
destoy-infra: tf-destroy-frontend tf-destroy-backend tf-destroy-core-infra 

#######################
####### DOCKER ########
#######################

build-docker-image:
	docker build -t ${docker-image-name}:${docker-image-version} -t ${docker-image-name}:latest -f dockerfile .

build-and-push-image:
	docker build -t ${docker-registry-name}/${docker-image-name}:latest \
		-t ${docker-registry-name}/${docker-image-name}:${docker-image-version} -f dockerfile . &&\
		docker push ${docker-registry-name}/${docker-image-name}:latest &&\
		docker push ${docker-registry-name}/${docker-image-name}:${docker-image-version}

run-app-locally:
	docker run --name ${docker-image-name} -p 5000:5000 ${docker-image-name}:latest

remove-app-locally:
	docker rm ${docker-image-name}

#######################
#### TF CORE-INFRA ####
#######################	

tf-prebuild-core-infra:
	cd infrastructure/core-infra &&\
		terraform init &&\
		terraform validate &&\
		terraform fmt -recursive

tf-plan-core-infra:
	cd infrastructure/core-infra &&\
		terraform plan -out=core-infra.tfplan

tf-apply-core-infra:
	cd infrastructure/core-infra &&\
		terraform apply --auto-approve core-infra.tfplan

tf-destroy-core-infra:
	cd infrastructure/core-infra &&\
		terraform apply --destroy core-infra.tfplan

#######################
##### TF BACKEND ######
#######################	

tf-prebuild-backend:
	cd infrastructure/backend &&\
		terraform init &&\
		terraform validate &&\
		terraform fmt -recursive
tf-plan-backend:
	cd infrastructure/backend &&\
		terraform plan -out=backend.tfplan

tf-apply-backend:
	cd infrastructure/backend &&\
		terraform apply --auto-approve backend.tfplan

tf-destroy-backend:
	cd infrastructure/backend &&\
		terraform apply --destroy backend.tfplan

#######################
##### TF FRONTEND #####
#######################	

tf-prebuild-frontend:
	cd infrastructure/frontend &&\
		terraform init &&\
		terraform validate &&\
		terraform fmt -recursive

tf-plan-frontend:
	cd infrastructure/frontend &&\
		terraform plan -out=frontend.tfplan

tf-apply-frontend:
	cd infrastructure/frontend &&\
		terraform apply --auto-approve frontend.tfplan

tf-destroy-frontend:
	cd infrastructure/frontend &&\
		terraform apply --destroy frontend.tfplan

#######################
##### TF MODULES ######
#######################

tf-module-update-readme:
	for module in $(tf-modules); do \
		cd terraform/modules/$$module &&\
		terraform-docs md tbl --output-file README.md  --output-mode inject . &&\
		cd ../../..; \
	done

tf-module-fmt:
	for module in $(tf-modules); do \
		cd terraform/modules/$$module &&\
		terraform fmt -recursive &&\
		cd ../../..; \
	done

#######################
##### K8S DEPLOY ######
#######################

k8s-deploy:
	kubectl apply -k k8s-manifests/

k8s-port-forward:
	kubectl port-forward -n demo-app-dev service/svc-demo-app 5500:80

k8s-delete-deploy-dev:
	kubectl delete deploy -n demo-app-dev deploy-demo-app
