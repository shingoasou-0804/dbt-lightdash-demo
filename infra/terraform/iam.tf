resource "google_project_iam_member" "analytics_job_user" {
  project = var.analytics_project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.dbt_sa.email}"
}

resource "google_bigquery_dataset_iam_member" "analytics_ds_writer" {
  project    = var.analytics_project_id
  dataset_id = google_bigquery_dataset.analytics_ds.dataset_id
  role       = "roles/bigquery.dataEditor"
  member     = "serviceAccount:${google_service_account.dbt_sa.email}"
}

resource "google_bigquery_dataset_iam_member" "raw_ds_viewer" {
  provider   = google.raw
  project    = var.raw_project_id
  dataset_id = google_bigquery_dataset.raw_ds.dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "serviceAccount:${google_service_account.dbt_sa.email}"
}

resource "google_project_iam_member" "raw_metadata_viewer" {
  project = var.raw_project_id
  role    = "roles/bigquery.metadataViewer"
  member  = "serviceAccount:${google_service_account.dbt_sa.email}"
}

resource "google_project_iam_member" "ld_jobuser" {
  project = var.analytics_project_id
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.lightdash_viewer.email}"
}

resource "google_bigquery_dataset_iam_member" "ld_viewer" {
  project    = var.analytics_project_id
  dataset_id = var.analytics_dataset_id
  role       = "roles/bigquery.dataViewer"
  member     = "serviceAccount:${google_service_account.lightdash_viewer.email}"
}
