
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.70.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.70.0"
    }
  }
}
