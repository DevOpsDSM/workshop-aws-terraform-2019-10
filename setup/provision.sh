#!/bin/bash
set -e

PASSWORD=$1
sudo yum update -y

set +e
echo "${PASSWORD}" | sudo passwd ec2-user --stdin
set -e

sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

wget https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip
unzip -o terraform_0.12.12_linux_amd64.zip
rm terraform_0.12.12_linux_amd64.zip
chmod +x terraform
sudo mv -f terraform /usr/local/bin/

(cd /home/ec2-user; tar -xvf /tmp/homeir.tar)

aws --version
terraform --version

aws s3api list-buckets
