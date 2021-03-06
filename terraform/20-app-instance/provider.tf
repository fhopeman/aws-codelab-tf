terraform {
  required_version = "0.15.0"
  required_providers {
    aws = {
      version = "3.37.0"
    }
    template = {
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}
