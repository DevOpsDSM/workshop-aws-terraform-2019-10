variable "aws_region" { default = "us-east-1" }

provider "aws" {
  region = var.aws_region
}

variable "bucket_prefix" {
  type    = string
  default = "devopsdsm-workshop"
}

resource "random_string" "bucket_suffix" {
  length  = 8
  upper   = false
  number  = false
  special = false
}

resource "aws_s3_bucket" "static_site" {
  bucket = "${var.bucket_prefix}-${random_string.bucket_suffix.result}"
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AddPerm",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_prefix}-${random_string.bucket_suffix.result}/*"
        }
    ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket       = "${aws_s3_bucket.static_site.bucket}"
  key          = "index.html"
  source       = "src/index.html"
  content_type = "text/html"
  etag         = "${md5(file("src/index.html"))}"
}

output "url" {
  value = "${aws_s3_bucket.static_site.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}
