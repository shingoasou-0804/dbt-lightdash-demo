terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.40"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.40"
    }
  }
}

provider "google" {
  alias   = "raw"
  project = var.raw_project_id
  region  = var.region
}

provider "google-beta" {
  alias   = "raw"
  project = var.raw_project_id
  region  = var.region
}

provider "google" {
  project = var.analytics_project_id
  region  = var.region
}

provider "google-beta" {
  project = var.analytics_project_id
  region  = var.region
}
