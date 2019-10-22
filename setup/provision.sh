#!/bin/bash
set -e

sudo yum update -y

wget https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip
unzip -o terraform_0.12.12_linux_amd64.zip
rm terraform_0.12.12_linux_amd64.zip
chmod +x terraform
sudo mv -f terraform /usr/local/bin/

aws --version
terraform --version
