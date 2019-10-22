# workshop-aws-terraform

The code here was used for a workshop at DevopsDSM to introduce participants to AWS and Terraform

## Setup

This folder was used by instructors to setup cloud VMs for participants to use during the workshop.

As an instructor, you can run this:

```
cd setup/
ssh-keygen
terraform init
terraform apply
```

Given you have aws credentials setup (for the workshop, a temporary AWS Orgnaization was setup)
