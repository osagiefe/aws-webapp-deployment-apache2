#!/bin/bash

set -e

echo "Updating apt cache..."
sudo apt update -y

echo "Installing required packages..."
sudo apt install -y apache2 unzip wget

echo "Stopping Apache..."
sudo systemctl stop apache2

echo "Removing existing website content..."
sudo rm -rf /var/www/html

echo "Recreating web root directory..."
sudo mkdir -p /var/www/html
sudo chown www-data:www-data /var/www/html
sudo chmod 755 /var/www/html

echo "Downloading website archive from GitHub..."
wget -O /tmp/jupiter-main.zip https://github.com/azeezsalu/jupiter/archive/refs/heads/main.zip

echo "Extracting website archive..."
unzip -o /tmp/jupiter-main.zip -d /tmp

echo "Copying website files into Apache web root..."
sudo cp -r /tmp/jupiter-main/* /var/www/html/

echo "Setting correct ownership..."
sudo chown -R www-data:www-data /var/www/html

echo "Starting and enabling Apache..."
sudo systemctl start apache2
sudo systemctl enable apache2

echo "Cleaning up..."
rm -f /tmp/jupiter-main.zip
rm -rf /tmp/jupiter-main

echo "Website deployment completed successfully."
