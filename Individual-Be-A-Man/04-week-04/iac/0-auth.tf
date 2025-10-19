# Setup terraform version and providers.

terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use latest version if possible
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }

    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
  }

}


provider "aws" {
  region  = var.region
  profile = "default"
}

# Get public IP address of client workstation via HTTP.





