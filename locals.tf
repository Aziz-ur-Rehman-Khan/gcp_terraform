locals {
  project_prefix = "${var.project_prefix}-${terraform.workspace}"
}
locals {
  # Read the content of the .env file for the specified environment
  env_content = file("./.env")

  # Parse the .env file content into a map of environment variables
  static_environment_variables = {
    for line in split("\n", local.env_content) :
    split("=", line)[0] => split("=", line)[1]
    if length(split("=", line)) == 2 &&
    substr(trimspace(line), 0, 1) != "#" &&
    trimspace(line) != ""
  }

  # Combine the parsed .env variables with other static variables
  environment_variables_map = merge(
    local.static_environment_variables,
    {
      REDIS_HOST   = module.memcached_redis.redis_host
      REDIS_PORT   = module.memcached_redis.redis_port
      DATABASE_URL = module.cloud_sql.postgres_connection_string
    }
  )

  # Convert the map to a list of objects
  environment_variables = [
    for key, value in local.environment_variables_map :
    {
      name  = key
      value = value
    }
  ]
}
