output "bucket_name" {
  description = "The name of the created Google Cloud Storage bucket"
  value       = google_storage_bucket.main_bucket.name
}

output "bucket_url" {
  description = "The base URL of the bucket, in the format gs://<bucket-name>"
  value       = google_storage_bucket.main_bucket.url
}

output "bucket_self_link" {
  description = "The URI of the created bucket"
  value       = google_storage_bucket.main_bucket.self_link
}