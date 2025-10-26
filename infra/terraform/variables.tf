variable "raw_project_id" {
  type = string
}

variable "analytics_project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "raw_location" {
  type    = string
  default = "US"
}

variable "analytics_location" {
  type    = string
  default = "US"
}

variable "raw_dataset_id" {
  type    = string
  default = "jaffle_raw"
}

variable "analytics_dataset_id" {
  type    = string
  default = "jaffle_analytics"
}

variable "github_repo" {
  type = string
}

variable "wif_pool_id" {
  type    = string
  default = "github-wif-pool"
}

variable "wif_provider_id" {
  type    = string
  default = "github-wif-provider"
}
