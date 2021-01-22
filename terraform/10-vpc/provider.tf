terraform {
  required_providers {
    aws = {
      version = "3.24.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}
