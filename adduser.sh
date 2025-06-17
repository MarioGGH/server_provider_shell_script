#!/bin/bash

# Ask for the username
read -p "Username: " user

# Create the user
sudo useradd -s /bin/bash -d /var/www/html/$user $user

# Create the user directory in /var/www/html/$user
sudo mkdir -p /var/www/html/$user/uploads

# Change ownership of the directory
sudo chown -R $user:$user /var/www/html/$user
sudo chown -R $user:$user /var/www/html/$user/uploads

# Set permissions for the user
sudo chmod a-w /var/www/html/$user
sudo chmod -R 755 /var/www/html/$user/uploads

# Set the password for the user
sudo passwd $user

# Verification message to confirm user creation and permissions
echo "Directory created and permissions assigned to user $user at /var/www/html/$user"
echo "Password assigned to user $user"
