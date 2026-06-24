module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v6.6.1"

  name = "${local.resource_prefix}-vpc"
  cidr = local.vpc_cidr
  azs  = local.azs

  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets

  create_igw           = true
  enable_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.tags
}

module "fck-nat" {
  source = "git::https://github.com/RaJiska/terraform-aws-fck-nat.git?ref=v1.6.0"

  name      = "${local.resource_prefix}-nat"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  ha_mode   = true

  update_route_tables = true
  route_tables_ids = {
    for idx, rt_id in module.vpc.private_route_table_ids :
    "private-route-table-${idx}" => rt_id
  }

  instance_type = "tg4.nano"

  tags = local.tags
}
