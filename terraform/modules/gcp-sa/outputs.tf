output "service_account_email" {
  value = google_service_account.account.email
}

output "service_account_key" {
  value     = google_service_account_key.key
  sensitive = true
}
