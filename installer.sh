#!/bin/bash

sudo apt install apache2
sudo apt install vsftpd

sudo systemctl start vsftpd
sudo systemctl enable vsftpd

echo "local_enable=YES\nwrite_enable=YES\nchroot_local_user=YES" > /etc/vsftpd.conf

sudo ufw allow 80
sudo ufw allow 20

sudo systemctl reload vsftpd
sudo systemctl reload apache2
