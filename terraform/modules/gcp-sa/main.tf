resource "google_service_account" "account" {
  project      = var.project
  account_id   = var.account_name
  display_name = var.account_name
  description  = var.description
}

resource "google_project_iam_member" "roles" {
  for_each = toset(var.roles)

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.account.email}"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.account.name
}
