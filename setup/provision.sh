#!/bin/bash

### Assign ec2-user's password
set -e

PASSWORD=$1
sudo yum update -y

set +e
echo "${PASSWORD}" | sudo passwd ec2-user --stdin
set -e

### Set ssh to accept passwords
sudo sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

### Install Terraform
wget https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip
unzip -o terraform_0.12.12_linux_amd64.zip
rm terraform_0.12.12_linux_amd64.zip
chmod +x terraform
sudo mv -f terraform /usr/local/bin/

### Make tf shortcut
mkdir -p ~/bin
ln -sf /usr/local/bin/terraform  ~/bin/tf

### Put Exercises in home directory
(cd /home/ec2-user; tar -xvf /tmp/homedir.tar)

### This sets the CDPATH so "cd execise#" works.
echo "export CDPATH=.:~" >> .bashrc

### This sets up command completion 
echo "complete -C /usr/local/bin/terraform terraform" >> .bashrc
echo "complete -C ~/bin/tf tf" >> .bashrc

aws --version
terraform --version
aws s3api list-buckets
