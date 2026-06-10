variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "The deployment environment (e.g., production, development)"
  type        = string
}
