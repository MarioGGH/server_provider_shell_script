#!/bin/bash

# Update repositories and install Apache2 and vsftpd
sudo apt update
sudo apt install -y apache2 vsftpd

# Start and enable Apache2 and vsftpd services
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2

# Remove the vsftpd config file and create a new one with updated settings
sudo rm /etc/vsftpd.conf
sudo touch /etc/vsftpd.conf

# vsftpd configuration (file /etc/vsftpd.conf)
echo "local_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "chroot_local_user=YES" | sudo tee -a /etc/vsftpd.conf
echo "allow_writable_chroot=YES" | sudo tee -a /etc/vsftpd.conf
echo "listen=YES" | sudo tee -a /etc/vsftpd.conf
echo "listen_ipv6=NO" | sudo tee -a /etc/vsftpd.conf
echo "pasv_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "pasv_min_port=30000" | sudo tee -a /etc/vsftpd.conf
echo "pasv_max_port=31000" | sudo tee -a /etc/vsftpd.conf
echo "secure_chroot_dir=/var/run/vsftpd/empty" | sudo tee -a /etc/vsftpd.conf
echo "listen_address=0.0.0.0" | sudo tee -a /etc/vsftpd.conf
echo "user_sub_token=$USER" | sudo tee -a /etc/vsftpd.conf
echo "local_root=/var/www/html/$USER" | sudo tee -a /etc/vsftpd.conf

# Firewall configuration
sudo ufw allow 80/tcp  # Allow HTTP (port 80)
sudo ufw allow 21/tcp  # Allow FTP (port 21)
sudo ufw allow 30000:31000/tcp # Allow passive port range (30000-31000)

# Reload services to apply changes
sudo systemctl reload vsftpd
sudo systemctl reload apache2

# Verify the status of the services
sudo systemctl status vsftpd
sudo systemctl status apache2
