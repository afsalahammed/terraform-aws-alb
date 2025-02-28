#!/bin/bash
# Update the package repository
sudo apt update -y

# Install Apache (for Ubuntu) or HTTPD (for Amazon Linux)
sudo apt install -y apache2

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Create a simple index.html file
echo "<h1>Welcome to My Application - $(hostname)</h1>" | sudo tee /var/www/html/index.html

# Restart Apache to apply changes
sudo systemctl restart apache2