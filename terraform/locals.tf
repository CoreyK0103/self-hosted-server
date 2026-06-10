locals {
  project_name    = "self-hosted-server"
  short_env       = var.environment == "production" ? "prod" : "dev"
  resource_prefix = "${local.project_name}-${local.short_env}"
}
