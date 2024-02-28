#!/bin/bash

sudo apt update -y
sudo apt install git curl -y
cd /home/ubuntu
git clone https://github.com/s4616/aws_project.git
sudo chown -R ubuntu:ubuntu aws_project

cd /home/ubuntu/aws_project
chmod u+x install-docker.sh && sudo ./install-docker.sh
sudo docker compose up -d --build