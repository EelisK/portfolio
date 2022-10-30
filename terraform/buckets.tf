resource "google_storage_bucket" "cloudbuild" {
  name     = "${var.gcp_project}_cloudbuild"
  project  = var.gcp_project
  location = "EU"

  force_destroy               = false
  uniform_bucket_level_access = true
}
