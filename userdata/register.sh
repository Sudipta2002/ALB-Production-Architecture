#!/bin/bash

dnf update -y

dnf install nginx -y

systemctl enable nginx

systemctl start nginx

INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

mkdir -p /usr/share/nginx/html/register

echo "<h1>REGISTER PAGE</h1>" > /usr/share/nginx/html/register/index.html

echo "<h2>$INSTANCE_ID</h2>" >> /usr/share/nginx/html/register/index.html