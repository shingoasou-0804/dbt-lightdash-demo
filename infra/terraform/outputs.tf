output "dbt_service_account_email" {
  value = google_service_account.dbt_sa.email
}

output "workload_identity_provider_name" {
  value = google_iam_workload_identity_pool_provider.provider.name
}
