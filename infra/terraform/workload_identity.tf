resource "google_iam_workload_identity_pool" "wif_pool" {
  provider                  = google-beta
  workload_identity_pool_id = var.wif_pool_id
  display_name              = "GitHub OIDC Pool"
  description               = "OIDC from GitHub Actions"
}

resource "google_iam_workload_identity_pool_provider" "provider" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.wif_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.wif_provider_id
  display_name                       = "GitHub OIDC Provider"
  description                        = "OIDC from GitHub Actions"
  attribute_condition                = "attribute.repository == '${var.github_repo}'"
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.ref"              = "assertion.ref"
    "attribute.workflow"         = "assertion.workflow"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository_owner" = "assertion.repository_owner"
    "attribute.aud"              = "assertion.aud"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "wif_binding" {
  service_account_id = google_service_account.dbt_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.wif_pool.name}/attribute.repository/${var.github_repo}"
}
