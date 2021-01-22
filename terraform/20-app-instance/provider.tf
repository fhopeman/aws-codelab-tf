terraform {
  required_providers {
    aws = {
      version = "3.24.0"
    }
    template = {
      version = "2.2.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}
