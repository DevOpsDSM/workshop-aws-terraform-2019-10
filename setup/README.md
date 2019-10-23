# setup 

In this lab, we will use the AWS Terraform Provider to create hosts for users to work on.

Setup password for instances to use.

```
export TF_VAR_password=pwgen --no-capitalize 8 -1
```
If you want 1 instance for testing use the basic terraform workflow.

```
terraform init
terraform plan
terraform apply

```

To use a seperate AWS profile use the AWS_PROFILE environment variable.  So plan, apply destroy would look like this.

```
AWS_PROFILE=profilename terraform plan
AWS_PROFILE=profilename terraform apply
AWS_PROFILE=profilename terraform destroy

```
To create moreww instances, use the instance_count variable on the coommand line, like this:
```
terraform plan --var 'instance_count=15'
terraform apply --var 'instance_count=15'
terraform destroy --var 'instance_count=15'
```

