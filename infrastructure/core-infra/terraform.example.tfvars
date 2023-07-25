project_id = "my-project-id"
default_region = "europe-west9" 
vpc_name = "flask-app"

repositories = [
  {
    location = "europe-west9"
    repository_name = "docker-registry-app"
    repository_description = "The docker registry for flask-app"
    repository_format = "DOCKER"
    kms_key_name  = "projects/<project_id>/locations/<default region>/keyRings/<keyring name>/cryptoKeys/<key name>"
  }
]
