resource "google_project_service" "analytics_services" {
  for_each = toset([
    "iam.googleapis.com",
    "sts.googleapis.com",
    "iamcredentials.googleapis.com",
    "bigquery.googleapis.com",
  ])
  project                    = var.analytics_project_id
  service                    = each.key
  disable_dependent_services = true
}

resource "google_project_service" "raw_services" {
  for_each = toset([
    "bigquery.googleapis.com",
  ])
  project                    = var.raw_project_id
  service                    = each.key
  disable_dependent_services = true
}

resource "google_service_account" "dbt_sa" {
  project      = var.analytics_project_id
  account_id   = "dbt-runner"
  display_name = "dbt Runner(WIF)"
}

resource "google_bigquery_dataset" "raw_ds" {
  provider    = google.raw
  project     = var.raw_project_id
  dataset_id  = var.raw_dataset_id
  location    = var.raw_location
  description = "raw seeds dataset"
}

resource "google_bigquery_dataset" "analytics_ds" {
  project     = var.analytics_project_id
  dataset_id  = var.analytics_dataset_id
  location    = var.analytics_location
  description = "analytics/marts dataset"
}

resource "google_service_account" "lightdash_viewer" {
  project      = var.analytics_project_id
  account_id   = "lightdash-viewer"
  display_name = "Lightdash read-only SA"
}
