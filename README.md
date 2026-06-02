# AWS Apache Webapp Deployment

  ## Project Scope 
Deploying a webapp on an AWS EC2 instance. Use Terraform to deploy the AWS infrastructure with apache2 webserver. 
Then use shell script to deployment the web application to run within apache2 webserver default web folder (/var/www/html).

# AWS Architecture Diagram
<img width="777" height="520" alt="Image" src="https://github.com/user-attachments/assets/37370b21-897d-4d6b-b952-0a0f2728f244" />


# Tools 
- Terraform
- AWS IAM account
- Github
- apache2 shell script
- web application installation shell script

# Steps:
  ## Build Terraform file
<img width="346" height="428" alt="Image" src="https://github.com/user-attachments/assets/0ebece74-fbbe-4824-8a8a-1b87b40fea2f" />

  ## Execute Terraform file to build the AWS infrastructure  
<img width="1191" height="371" alt="Image" src="https://github.com/user-attachments/assets/62e864ab-1e45-4aa3-b75e-4ab7f88de5a5" />

  ## AWS instance
<img width="1861" height="865" alt="Image" src="https://github.com/user-attachments/assets/c6640d35-f638-4477-b347-73bcab685086" />

  ## Apache Default page
<img width="807" height="778" alt="Image" src="https://github.com/user-attachments/assets/67f3637d-6233-46a1-81ad-e3cee8349fe0" />

  ## Connect via ssh to EC2 instance
<img width="1800" height="741" alt="Image" src="https://github.com/user-attachments/assets/7cfe1af0-9b0a-4f72-b37b-f1f39def9b32" />

<img width="772" height="487" alt="Image" src="https://github.com/user-attachments/assets/5e7de6b2-9718-4a99-aba9-40060c9b95e8" />

  ## Create a shell script for webapp install
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

  ## Make script executable for everyone
chmod +x installwebsite.sh

  ## Execute script on the apache2 server
<img width="842" height="522" alt="Image" src="https://github.com/user-attachments/assets/59dd3ee7-7227-4894-9b65-d4137baf3d07" />

<img width="1270" height="200" alt="Image" src="https://github.com/user-attachments/assets/d44ea5e9-99fc-4ef4-ada5-795f0f9884e7" />

# Webapp Deployed
<img width="1370" height="807" alt="Image" src="https://github.com/user-attachments/assets/e7c98961-6da4-473b-9665-b5d11527c70b" />

# Project Challenges
- My original webapp deployment code was an ansible yaml file. I needed to convert this to a shell script.

# Solution
- I prompted ChatGPT to convert my ansible yaml file to a shell script, and I was able to deploy website successfully