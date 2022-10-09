module "continuous-integration-account" {
  source = "./modules/gcp-sa"

  project      = var.gcp_project
  account_name = "continuous-integration-account"
  description  = "Github actions continuous integration service account"

  roles = ["roles/owner"]
}
