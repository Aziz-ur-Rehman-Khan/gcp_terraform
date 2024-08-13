README
================

Overview
--------

This repository contains Terraform configurations for setting up a Google Cloud Platform (GCP) infrastructure. The infrastructure includes various services such as Cloud Storage, Cloud SQL, Redis, Cloud Run, Load Balancer, VPC, and more. The configurations are modularized for better organization and reusability.

Prerequisites
-------------

* Terraform v0.12+
* Google Cloud SDK
* A GCP project with billing enabled

Structure
---------

The repository is organized into the following main directories and files:

* `main.tf`: Main configuration file that includes all the modules.
* `variables.tf`: Defines the input variables for the Terraform configurations.
* `outputs.tf`: Defines the output values for the Terraform configurations.
* `provider.tf`: Configures the GCP provider.
* `locals.tf`: Defines local values used in the configurations.
* `modules/`: Contains subdirectories for each module (e.g., storage, cloudsql, redis, etc.).

Modules
-------

### Storage

Manages a Google Cloud Storage bucket. See `modules/storage`.

### Cloud SQL

Manages a Cloud SQL instance with PostgreSQL. See `modules/cloudsql`.

### Redis

Manages a Redis instance with private service access. See `modules/redis`.

### Load Balancer

Sets up a load balancer for Cloud Run services. See `modules/loadbalancer`.

### VPC Connector

Creates a VPC access connector. See `modules/vpc_connector`.

Usage
-----

1. Clone the repository:
>
2. Initialize Terraform:
init
3. Review and modify variables:
Edit the `variables.tf` file to set the appropriate values for your environment.
4. Apply the configurations:
apply
Confirm the apply with yes.

Variables
---------

The `variables.tf` file defines several input variables. Here are some key variables:

* `project_id`: The GCP project ID where resources will be created.
* `region`: The GCP region where resources will be created.
* `project_prefix`: A prefix to be used for naming resources.
* `db_user_name`: The username for the database instance.
* `db_password`: The password for the database user.

Outputs
-------

The `outputs.tf` file defines the output values that are useful for accessing the created resources. Some key outputs include:

* `repository_url`: The URL of the Docker repository in Artifact Registry.
* `database_connection_name`: The connection name of the Cloud SQL instance.
* `cloud_run_service_url`: The URL of the Cloud Run service.
* `redis_connection_string`: The connection string for the Redis instance.

Local Values
------------

Local values are defined in the `locals.tf` file to simplify and reuse common values. Some of these values are sourced from a `.env` file to keep sensitive information and environment-specific configurations separate from the codebase.

### .env File

The `.env` file should be placed in the root directory of the repository and contain key-value pairs for the local values. Here is an example of what the `.env` file might look like:

```
PROJECT_ID=my-gcp-project
REGION=us-central1
PROJECT_PREFIX=myproject
DB_USER_NAME=mydbuser
DB_PASSWORD=mydbpassword
```

Make sure to add the `.env` file to your `.gitignore` to prevent it from being committed to the repository.

Provider Configuration
---------------------

The `provider.tf` file configures the GCP provider.