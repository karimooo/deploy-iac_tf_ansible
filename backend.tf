terraform {
  required_version = ">=0.12.0"
  required_providers {
    aws = "=3.0.0"
  }
  backend "s3" {
    region  = "eu-west-3"
    profile = "default"
    key     = "terraformstatefile"
    bucket  = "my-ak-devops-terraform-state-files-bucket"

  }
}
