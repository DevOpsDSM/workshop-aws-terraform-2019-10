# exercise1

In this exercise, we will use the AWS Terraform Provider to create a simple static webiste using AWS S3.

_NOTE_: everything in this exercise should be run from the ec2 host provided to you.

## Steps

```
cd exercise1
```

First inspect the `main.tf` file to see all of the configuration and resources we will use here.

```
nano main.tf
```

The important Terraform resources are `aws_s3_bucket` and `aws_s3_bucket_object. These resources will actuall do the work of creating/updating our S3 bucket.

Try running this:

```
terraform init
terraform plan
```

Inspect the output to see what Terraform thinks it needs to do.

Actually apply:

```
terraform apply
```

View your outputs, which will contain the public url you can use to view your site.

## Experiements

- View what happens if you change the bucket name prefix
- View what happens if you change your index.html content
