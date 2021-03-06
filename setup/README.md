# setup 

In this lab, we will use the AWS Terraform Provider to create hosts for users to work on.

Setup password for instances to use.

```
export TF_VAR_password=`pwgen --no-capitalize 8 -1`
```
If you want 1 instance for testing use the basic terraform workflow.

```
wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
unzip terraform_0.12.20_linux_amd64.zip
export PATH=.:$PATH
terraform version
```

Ensure you are running 0.12+

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
To create more instances, use the instance_count variable on the command line.  Replace X with the number of instances you want to build.
```
terraform plan --var 'instance_count=X'
terraform apply --var 'instance_count=X'
terraform destroy --var 'instance_count=X'
```

