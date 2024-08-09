module "storage" {
  source  = "./modules/storage"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
}
module "cloud_sql" {
  source     = "./modules/cloudsql"
  project    = var.project_id
  region     = var.region
  prefix     = local.project_prefix
  network    = module.vpc.network_self_link
  network_id = module.vpc.network_id

}

module "memcached_redis" {
  source     = "./modules/redis"
  project    = var.project_id
  region     = var.region
  prefix     = local.project_prefix
  network_id = module.vpc.network_id
  network    = module.vpc.network_name
}
module "load_balancer" {
  source                 = "./modules/loadbalancer"
  project                = var.project_id
  region                 = var.region
  prefix                 = local.project_prefix
  cloud_run_service_name = module.cloud_run.service_name
  cloud_run_service_id   = module.cloud_run.service_id
  domain_name = var.domain_name

}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0"

  project_id   = var.project_id
  network_name = "${local.project_prefix}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "${local.project_prefix}-subnet"
      subnet_ip             = "10.10.0.0/16"
      subnet_region         = var.region
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "Cloud Run VPC Connector Subnet"
    }
  ]
}

resource "google_vpc_access_connector" "connector" {
  name          = "vpc-access-connector"
  ip_cidr_range = "10.58.167.0/28"
  network       = module.vpc.network_name
}
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
module "cloud_nat" {
  source    = "./modules/cloudnat"
  project   = var.project_id
  region    = var.region
  prefix    = local.project_prefix
  network   = module.vpc.network_id
  subnet_id = tostring(module.vpc.subnets_ids[0])
}
module "artifact_registry" {
  source  = "./modules/artifact_registry"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
}
