#!/bin/bash

# Update system
sudo apt-get update -y

# Install dependencies
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    git

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Get public IP
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)

# Create directory structure
mkdir -p /home/ubuntu/multi-tier-app
cd /home/ubuntu/multi-tier-app

# Create .env file
cat <<EOT > .env
PUBLIC_IP=$PUBLIC_IP
DB_USER=todo_user
DB_PASSWORD=securepassword123
DB_NAME=todo_app
DB_ROOT_PASSWORD=rootpassword123
EOT

# Clone application (replace with your actual repo)
git clone https://github.com/your-repo/multi-tier-app.git docker-app
cd docker-app

# Start the application
docker-compose -f docker-compose.yml up -d

# Create a simple info page
cat <<EOT > /home/ubuntu/multi-tier-app/info.html
<html>
<head><title>Application Deployment Info</title></head>
<body>
<h1>Multi-Tier Application Deployment</h1>
<p>Deployment successful!</p>
<ul>
<li><a href="http://$PUBLIC_IP:8080" target="_blank">Frontend</a></li>
<li><a href="http://$PUBLIC_IP:5000" target="_blank">API</a></li>
<li><a href="http://$PUBLIC_IP:8081" target="_blank">phpMyAdmin</a></li>
</ul>
<p>Deployed at: $(date)</p>
</body>
</html>
EOT

# Install a simple web server to show the info page
sudo apt-get install -y python3
cd /home/ubuntu/multi-tier-app
python3 -m http.server 8000 &