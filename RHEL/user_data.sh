#!/bin/bash
sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
#sudo useradd ssm-user
sudo echo 'ssm-user    ALL=(ALL)   NOPASSWD:ALL'   >   /etc/sudoers.d/ssm-agent-users
sudo chmod 440 /etc/sudoers.d/ssm-agent-users
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
sudo hostnamectl set-hostname test-ami