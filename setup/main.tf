variable "instance_count" {}

provider "aws" {
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "workshop-key"
  public_key = file("id_rsa.pub")
}

module "security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "workshop"
  description = "Security group for workshop usage with EC2 instance"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp", "ssh-tcp"]
  egress_rules        = ["all-all"]
}

resource "aws_kms_key" "this" {
}

resource "aws_iam_instance_profile" "profile" {
  name = "workshop-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "workshop-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "policy" {
  name = "workshop-policy"
  role = aws_iam_role.role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}


module "ec2" {
  source                 = "../../terraform-aws-ec2-instance/"

  instance_count = var.instance_count

  name          = "workshop-normal"
  use_num_suffix = true
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.medium"
  subnet_id     = tolist(data.aws_subnet_ids.all.ids)[0]
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
  key_name      = aws_key_pair.deployer.key_name

  iam_instance_profile = aws_iam_instance_profile.profile.name

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 10
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp2"
      volume_size = 5
      encrypted   = true
      kms_key_id  = aws_kms_key.this.arn
    }
  ]
}

output "public_dns" {
  value = module.ec2.public_dns
}