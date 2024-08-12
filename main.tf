module "storage" {
  source  = "./modules/storage"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
}
module "cloud_sql" {
  source       = "./modules/cloudsql"
  project      = var.project_id
  region       = var.region
  prefix       = local.project_prefix
  network      = module.vpc.network_self_link
  network_id   = module.vpc.network_id
  db_name      = var.db_name
  db_password  = var.db_password
  db_port      = var.db_port
  db_user_name = var.db_user_name
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
  domain_name            = var.domain_name

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
