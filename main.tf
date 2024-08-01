module "redis" {
  source        = "./modules/redis"

  name          = local.redis_instance_name
  region         = "us-central1"
  tier           = "STANDARD_HA"
  memory_size_gb = 2
  redis_version  = "REDIS_6_X"
}

module "cloudsql" {
  source         = "./modules/cloudsql"
  name           = local.database_instance_name
  region         = "us-central1"
  database_version = "POSTGRES_13"
  tier           = "db-f1-micro"
  db_user =       "postgres"
}

module "cloudrun" {
  source    = "./modules/cloudrun"
  name                         = "cloudrun-srv"
  location                     = "us-central1"
  container_image              = "us-docker.pkg.dev/cloudrun/container/hello"
  max_scale                    = "1000"
  cloudsql_instance_connection_name = module.cloudsql.instance_connection_name
  redis_host                   = module.redis.redis_host
  redis_port                   = module.redis.redis_port
  project_id                   = "voodoo-409609"
}

# module "artifact_registry" {
#   source   = "./modules/artifact_registry"
#   name     = "my-artifact-registry"
#   location = "us-central1"
# }
