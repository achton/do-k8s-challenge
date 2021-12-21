# backend.tf
# Remote TF state using a DO Spaces bucket
terraform {
  backend "s3" {
    endpoint                    = "fra1.digitaloceanspaces.com"
    region                      = "us-east-1" # mandatory but unused in DO
    key                         = "dok8schallenge.tfstate"
    bucket                      = "achtonml"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
