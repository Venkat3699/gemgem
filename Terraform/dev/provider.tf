terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-s3-bucket-123"
    key          = "terraform/terraform.tfstate"
    encrypt      = true
    region       = "ap-south-1"
    # use_lockfile = true
  }
}

provider "aws" {
  region = var.region
}