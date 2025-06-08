#!/bin/bash

yum update -y


amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


cd /home/ec2-user
rm -rf pr2
git clone https://github.com/eminajusufovic/pr2.git
chown -R ec2-user:ec2-user pr2

cd pr2
sudo -u ec2-user /usr/local/bin/docker-compose up -d
