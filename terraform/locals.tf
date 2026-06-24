locals {
  project_name    = "self-hosted-server"
  short_env       = var.environment == "production" ? "prod" : "dev"
  resource_prefix = "${local.project_name}-${local.short_env}"

  vpc_cidr        = "10.0.0.0/16"
  azs             = ["eu-west-1a"]
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.2.0/24"]

  tags = {
    Name        = local.project_name
    Environment = var.environment
  }
}
