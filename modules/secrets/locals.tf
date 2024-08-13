locals {
  # Read the content of the .env file for the specified secret
  env_content = file("./.env")

  # Parse the .env file content into a map of secret variables
  static_secret_variables = {
    for line in split("\n", local.env_content) :
    split("=", line)[0] => split("=", line)[1]
    if length(split("=", line)) == 2 &&
    substr(trimspace(line), 0, 1) != "#" &&
    trimspace(line) != ""
  }

  # Combine the parsed .env variables with other static variables
  secret_variables_map = merge(
    local.static_secret_variables,
    {
      REDIS_HOST   = module.memcached_redis.redis_host
      REDIS_PORT   = module.memcached_redis.redis_port
      DATABASE_URL = module.cloud_sql.postgres_connection_string
    }
  )

  # Convert the map to a list of objects
  secret_variables = [
    for key, value in local.secret_variables_map :
    {
      name  = key
      value = value
    }
  ]
}
