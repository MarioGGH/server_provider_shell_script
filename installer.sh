#!/bin/bash

# Instalar Apache2 y vsftpd
sudo apt update
sudo apt install -y apache2 vsftpd

# Iniciar y habilitar los servicios
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2

# Configurar vsftpd
echo "local_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "chroot_local_user=YES" | sudo tee -a /etc/vsftpd.conf
echo "allow_writable_chroot=NO" | sudo tee -a /etc/vsftpd.conf

# Configurar el firewall (solo puertos necesarios)
sudo ufw allow 80/tcp  # Permitir HTTP (puerto 80)
sudo ufw allow 20/tcp  # Permitir FTP (puerto 21)

# Recargar servicios
sudo systemctl reload vsftpd
sudo systemctl reload apache2

