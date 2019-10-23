variable "aws_region" { default = "us-east-1" }

provider "aws" {
  region = var.aws_region
}

variable "bucket_name" {
  type    = string
}

data "aws_s3_bucket_object" "index" {
  bucket = var.bucket_name
  key    = "index.html"
}

output "index_content" {
  value = data.aws_s3_bucket_object.index.body
}
