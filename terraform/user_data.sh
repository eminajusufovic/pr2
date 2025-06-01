#!/bin/bash
yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
cd /home/ec2-user
rm -rf ISO-projekat2
git clone https://github.com/eminajusufovic/ISO-projekat2.git
cd ISO-projekat2
sudo -u ec2-user docker-compose up -d
