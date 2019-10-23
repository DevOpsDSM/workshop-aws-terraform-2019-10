# workshop-aws-terraform

The code here was used for a workshop at DevopsDSM to introduce participants to AWS and Terraform

## Instructor Setup

This folder was used by instructors to setup cloud VMs for participants to use during the workshop.

_NOTE_: because this is a short workshop, there were some corners cut around instance ssh access. Forgive and forget. Also don't do this...

As an instructor, you can run this:

```
cd setup/
ssh-keygen
terraform init
terraform apply
```

Given you have aws credentials setup (for the workshop, a temporary AWS Orgnaization was setup)

## Participants

## Setup

All a participant needs is an SSH client (during this workshop, chromebooks were provided)

Get a public dns name and a password from your instructor, then:

```
ssh workshop@some-public-aws.com
```

Onced ssh, you have a few tools available:

- awscli
- terraform

## Workshop Exercises

### Exercise 1

[click](exercise1/README.md)

### Exercise 2

[click](exercise2/README.md)
