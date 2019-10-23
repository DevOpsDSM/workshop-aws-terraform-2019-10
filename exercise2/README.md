# exercise2

In this exercise, we will use `exercise1` resources to do some inspection and see how IAM works.

We will also see how you can separate terraform resources by using data sources.


_NOTE_: everything in this exercise should be run from the ec2 host provided to you.

## Steps

```
cd exercise2
```

## Experiements

```
aws s3api list-buckets
```

Because we are all using the same AWS Organization, region and permissions, you should be able to see
the other participants buckets!

Try inspecting another resource:

```
export AWS_DEFAULT_REGION=us-east-1
aws ec2 describe-instances
```

Your ec2 instance you are logged into only has S3 permissions, so you should get access denied.

Now inspect the `main.tf` file to see all of the configuration and resources we will use here.

```
nano main.tf
```

The important Terraform resources is `data.aws_s3_bucket_object`.

Try running this:

```
terraform init
terraform plan
```

```
terraform apply
```

This will prompt you a bucket name. Grab one of the names from the `list-buckets` command earlier (not yours!).

Terraform will now grab the index file from their bucket and show you their content!
