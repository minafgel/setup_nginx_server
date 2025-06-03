# Nginx Web Server Setup Script (Ubuntu)

This Bash script automates the process of installing and configuring a basic Nginx web server on an Ubuntu machine. It sets up a virtual host, creates a sample webpage, enables HTTPS using Let's Encrypt, and configures the firewall.

---

## Features

- Installs and configures Nginx
- Creates a custom web root for your domain
- Sets up a sample HTML page
- Enables HTTPS using Certbot & Let's Encrypt
- Configures UFW (Uncomplicated Firewall)
- Automatically reloads Nginx with the new configuration

---

## Usage

1. **Update the domain variable** in the script:
   ```bash
   DOMAIN="yourdomain.com"

2. Make the script executable:
     ```bash
     chmod +x setup_nginx_server.sh
3. Run the script:
  ./setup_nginx_server.sh

## Requirements
* Ubuntu 20.04/22.04 server (tested)

* A registered domain name pointing to your server’s public IP

* sudo privileges

Made with love
