variable "aws_region" { default = "us-east-1" }

provider "aws" {
  region = var.aws_region
}

variable "bucket_name" {
  type = string
}

resource "aws_s3_bucket" "static_site" {
  bucket = var.bucket_name
  acl    = "public-read"
//  policy =

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
  bucket = "${aws_s3_bucket.static_site.bucket}"
  key = "index.html"
  source = "src/index.html"
  content_type = "text/html"
  etag = "${md5(file("src/index.html"))}"
}

output "url" {
  value = "${aws_s3_bucket.static_site.bucket}.s3-website-${var.aws_region}.amazonaws.com"
}
