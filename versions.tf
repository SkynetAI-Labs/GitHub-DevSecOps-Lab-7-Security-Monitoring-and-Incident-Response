terraform {
  required_version = "= 1.16.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.69.1"
    }
  }
}

provider "aws" {
  region = "eu-north-1"

  default_tags {
    tags = {
      Project   = "GitHub-DevSecOps-Lab-7"
      Purpose   = "Security monitoring and incident response"
      ManagedBy = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_role" "operator" {
  name = "AccountFullAccessRole"
}
