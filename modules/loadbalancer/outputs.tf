output "static_ip" {
  description = "The static IP address for the load balancer"
  value       = google_compute_global_address.static_ip.address
}
output "https_endpoint" {
  description = "The HTTPS endpoint URL for the load balancer. This URL is constructed using the static IP address of the load balancer and port 443 for secure HTTP connections."
  value       = "https://${google_compute_global_address.static_ip.address}:443"
}
