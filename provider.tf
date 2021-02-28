terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = ">=3.0.0"
  }
  backend "s3" {
    region  = "us-east-1"
    profile = "default"
    key     = "flashcards"
    bucket  = "drakeworld-state"
  }
}

provider "aws" {
  region = var.region
}