module "s3_bucket" {
  #checkov:skip=CKV_AWS_144
  #checkov:skip=CKV2_AWS_61
  #checkov:skip=CKV_AWS_18
  #checkov:skip=CKV2_AWS_62

  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v5.14.0"

  bucket        = "self-hosted-server-init-bucket"
  force_destroy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning = {
    enabled = true
  }
}
