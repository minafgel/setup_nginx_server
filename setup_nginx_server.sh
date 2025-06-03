#!/bin/bash

# Variables
DOMAIN="example.com"
WEB_ROOT="/var/www/$DOMAIN/html"
NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"

# System update
echo "Updating packages."
sudo apt update && sudo apt upgrade -y

# Install Nginx
echo "Installing Nginx."
sudo apt install nginx -y

# Configure UFW firewall
echo "Enabling UFW and allowing Nginx traffic."
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

# Create website root directory
echo "Creating web root at $WEB_ROOT."
sudo mkdir -p $WEB_ROOT
sudo chown -R $USER:$USER $WEB_ROOT
sudo chmod -R 755 /var/www

# Add sample index.html
echo "<html><head><title>Welcome to $DOMAIN</title></head><body><h1>Nginx is working!</h1></body></html>" > $WEB_ROOT/index.html

# Create Nginx server block config
echo "Creating Nginx config for $DOMAIN."
sudo bash -c "cat > $NGINX_CONF" <<EOF
server {
    listen 80;
    server_name $DOMAIN www.$DOMAIN;

    root $WEB_ROOT;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

# Enable the new site and reload Nginx
echo "Enabling site and reloading Nginx."
sudo ln -s $NGINX_CONF /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

# Install Certbot and configure HTTPS
echo "Installing Certbot and enabling HTTPS."
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN

# Final restart
sudo systemctl restart nginx

echo "$DOMAIN server has been configured with Nginx and HTTPS successfully!"
