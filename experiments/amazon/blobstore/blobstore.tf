# @see https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/1.7.0
module "amazon_blobstore" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = var.s3_bucket_name
  acl    = "public-read"
  force_destroy = true

  versioning = {
    enabled = true
  }
}

variable "s3_bucket_name" {}

output "s3_bucket_arn" {
  value = module.this_s3_bucket_arn
}

output "s3_bucket_domain_name" {
  value = module.this_s3_bucket_bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  value = module.this_s3_bucket_bucket_regional_domain_name
}

output "s3_bucket_hosted_zone_id" {
  value = module.this_s3_bucket_hosted_zone_id
}

provider "aws" {
  version = ">= 3.9.0"
}