module "cloud_run" {
  source  = "GoogleCloudPlatform/cloud-run/google"
  version = "~> 0.11"

  service_name          = "${local.project_prefix}-cloudrun-service"
  project_id            = var.project_id
  location              = var.region
  image                 = "gcr.io/kilow-431017/kilow-staging@sha256:06af6b5b33fe52cfc4c1252adef38de0a6f16f489ee079f30bad62aad570a518"
  service_account_email = "github-workflow@kilow-431017.iam.gserviceaccount.com"
  env_vars              = local.environment_variables

  ports = {
    port = 3000
    name = "http1"
  }

  template_annotations = {
    "autoscaling.knative.dev/maxScale"        = 4
    "autoscaling.knative.dev/minScale"        = 1
    "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.connector.id
    "run.googleapis.com/vpc-access-egress"    = "all-traffic"
    "run.googleapis.com/cloudsql-instances"   = module.cloud_sql.sql_instance_connection_name
    "run.googleapis.com/cpu-throttling"       = "false"
    "run.googleapis.com/startup-cpu-boost"    = "true"
  }

}
resource "google_cloud_run_service_iam_binding" "default" {
  location = module.cloud_run.location
  service  = module.cloud_run.service_name
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}