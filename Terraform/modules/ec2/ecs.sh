#!bin/bash
sudo apt update
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1> Welcome to Nginx on ECS Instance </h1>" > /usr/share/nginx/html/index.html
sudo systemctl restart nginx