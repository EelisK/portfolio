terraform {
  backend "gcs" {
    bucket = "terraform-state-kostiainendev"
  }
}
