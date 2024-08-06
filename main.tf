module "serverless_vpc_connector" {
  source  = "./modules/vpc_connector"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
  network = "default"
}

module "cloud_sql" {
  source  = "./modules/cloudsql"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix

}

module "memcached_redis" {
  source  = "./modules/redis"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
}

module "load_balancer" {
  source                 = "./modules/loadbalancer"
  project                = var.project_id
  region                 = var.region
  prefix                 = local.project_prefix
  cloud_run_service_name = module.cloud_run.service_name
}

module "cloud_run" {
  source                   = "./modules/cloudrun"
  project                  = var.project_id
  region                   = var.region
  prefix                   = local.project_prefix
  container_image          = module.artifact_registry.repository_url
  redis_uri                = "${module.memcached_redis.redis_host}:${module.memcached_redis.redis_port}"
  cloudsql_connection_name = module.cloud_sql.sql_instance_connection_name
  env_files                = "./.env"

}

module "cloud_nat" {
  source  = "./modules/cloudnat"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
  network = "default"
}

module "artifact_registry" {
  source  = "./modules/artifact_registry"
  project = var.project_id
  region  = var.region
  prefix  = local.project_prefix
}
