terraform {
  backend "gcs" {
    bucket = "dbt-lightdash-demo-474103-tfstate"
    prefix = "infra/terraform"
  }
}
