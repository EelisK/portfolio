locals {
  cloud_run_a_records = [
    "216.239.32.21",
    "216.239.34.21",
    "216.239.36.21",
    "216.239.38.21",
  ]
  cloud_run_aaaa_records = [
    "2001:4860:4802:32::15",
    "2001:4860:4802:34::15",
    "2001:4860:4802:36::15",
    "2001:4860:4802:38::15",
  ]
}

# gcloud dns dns-keys list --zone kostiainen-dev
# gcloud dns dns-keys describe --zone kostiainen-dev <ID> --format "value(ds_record())"
resource "google_dns_managed_zone" "default" {
  name        = "kostiainen-dev"
  dns_name    = "kostiainen.dev."
  description = "Zone for kostiainen.dev and all subdomains"
  dnssec_config {
    state = "on"
  }
}

resource "google_dns_record_set" "default_soa" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "SOA"
  ttl          = 21600

  rrdatas = [
    "${google_dns_managed_zone.default.name_servers[0]} cloud-dns-hostmaster.google.com. 1 21600 3600 259200 300"
  ]
  depends_on = [google_dns_managed_zone.default]
}

resource "google_dns_record_set" "default_ns" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "NS"
  ttl          = 21600

  rrdatas    = google_dns_managed_zone.default.name_servers
  depends_on = [google_dns_managed_zone.default]
}

resource "google_dns_record_set" "default_aaaa" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "AAAA"
  ttl          = 300

  rrdatas    = local.cloud_run_aaaa_records
  depends_on = [google_dns_managed_zone.default]
}


resource "google_dns_record_set" "default_a" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "A"
  ttl          = 300

  rrdatas    = local.cloud_run_a_records
  depends_on = [google_dns_managed_zone.default]
}

resource "google_dns_record_set" "default_txt" {
  name         = google_dns_managed_zone.default.dns_name
  managed_zone = google_dns_managed_zone.default.name
  type         = "TXT"
  ttl          = 300

  rrdatas = [
    "\"google-site-verification=Rhdr7YLDDK_8CYTEilQrALVsVDAsupEbD7Xwq2uNxW8\"",
  ]
  depends_on = [google_dns_managed_zone.default]
}

