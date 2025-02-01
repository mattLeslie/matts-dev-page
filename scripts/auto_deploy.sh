#!/bin/bash

set -e  # Exit immediately if a command fails

# Load environment variables from .env.local if it exists
if [ -f .env.local ]; then
  export $(grep -v '^#' .env.local | xargs)
fi

DEPLOY_DIR="/var/www/html"
LOCAL_DIST_DIR="$HOME/dist"

# 🛠 1. Update System
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# 🛠 2. Install Required Packages
echo "Installing dependencies..."
sudo apt install -y nginx certbot python3-certbot-nginx

# 🛠 3. Ensure SSL Certificate is Installed
echo "Checking for SSL certificate..."
if [ ! -f "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" ]; then
    echo "Obtaining SSL certificate..."
    sudo certbot certonly --standalone -d $DOMAIN -d $WWW_DOMAIN --non-interactive --agree-tos -m matt.127.leslie@gmail.com
else
    echo "SSL certificate already installed."
fi

# 🛠 4. Deploy the Uploaded `dist/` Folder
echo "Deploying Vue files..."
sudo rm -rf "$DEPLOY_DIR"/*
sudo mv "$LOCAL_DIST_DIR"/* "$DEPLOY_DIR"

# 🛠 5. Set Correct Permissions
echo "Setting file permissions..."
sudo chown -R www-data:www-data "$DEPLOY_DIR"
sudo chmod -R 755 "$DEPLOY_DIR"

# 🛠 6. Configure Nginx **After SSL Certificate is Issued**
echo "Configuring Nginx..."
NGINX_CONFIG="/etc/nginx/sites-available/default"

sudo tee "$NGINX_CONFIG" > /dev/null <<EOF
server {
    listen 80;
    server_name $DOMAIN $WWW_DOMAIN;

    location /.well-known/acme-challenge/ {
        root /var/www/html;
    }

    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl;
    server_name $DOMAIN $WWW_DOMAIN;

    ssl_certificate /etc/letsencrypt/live/$DOMAIN/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/$DOMAIN/privkey.pem;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri /index.html;
    }
}
EOF

# 🛠 7. Restart Nginx
echo "Restarting Nginx..."
sudo nginx -t && sudo systemctl restart nginx

# 🛠 8. Enable Auto-Renewal for SSL
echo "Setting up Certbot auto-renewal..."
sudo systemctl enable certbot.timer
sudo systemctl restart certbot.timer

# ✅ Deployment Complete
echo "✅ Deployment complete! Your Vue app is live at: https://$DOMAIN"
