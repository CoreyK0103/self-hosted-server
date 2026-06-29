resource "aws_security_group" "lambda_test_sg" {
  name        = "${local.resource_prefix}-lambda-test-sg"
  description = "Security group for NAT test Lambda"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${local.resource_prefix}-lambda-test-sg" })
}

module "lambda_test" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git?ref=23d00f7daef40091e87ed2f9dc5d8532e9d2cc22"

  function_name = "${local.resource_prefix}-nat-test"
  description   = "Lambda to test NAT gateway by fetching external IP"
  handler       = "test_lambda.handler"
  runtime       = "python3.14"

  source_path = "${path.module}/../lambda"

  vpc_subnet_ids         = module.vpc.intra_subnets
  vpc_security_group_ids = [aws_security_group.lambda_test_sg.id]
  attach_network_policy  = true

  environment_variables = {
    IP_CHECK_URL = "https://api.ipify.org?format=json"
  }

  tags = local.tags
}
