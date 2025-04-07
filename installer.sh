#!/bin/bash

# Actualizar los repositorios e instalar Apache2 y vsftpd
sudo apt update
sudo apt install -y apache2 vsftpd

# Iniciar y habilitar los servicios de Apache2 y vsftpd
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2

#Borramos el archivo vsftpd y creamos uno nuevo con la nueva config
sudo rm /etc/vsftpd.conf
sudo touch /etc/vsftpd.conf

# Configuración de vsftpd (archivo /etc/vsftpd.conf)
echo "local_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "chroot_local_user=YES" | sudo tee -a /etc/vsftpd.conf
echo "allow_writable_chroot=NO" | sudo tee -a /etc/vsftpd.conf
echo "listen=YES" | sudo tee -a /etc/vsftpd.conf
echo "listen_ipv6=NO" | sudo tee -a /etc/vsftpd.conf
echo "pasv_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "pasv_min_port=30000" | sudo tee -a /etc/vsftpd.conf
echo "pasv_max_port=31000" | sudo tee -a /etc/vsftpd.conf
echo "secure_chroot_dir=/var/run/vsftpd/empty" | sudo tee -a /etc/vsftpd.conf
echo "listen_address=0.0.0.0" | sudo tee -a /etc/vsftpd.conf
echo "user_sub_token=$USER" | sudo tee -a /etc/vsftpd.conf
echo "local_root=/var/www/html/$USER" | sudo tee -a /etc/vsftpd.conf

# Configuración del firewall
sudo ufw allow 80/tcp  # Permitir HTTP (puerto 80)
sudo ufw allow 21/tcp  # Permitir FTP (puerto 21)
sudo ufw allow 30000:31000/tcp # Permitir el rango de puertos pasivos (30000-31000)

# Recargar los servicios para aplicar los cambios
sudo systemctl reload vsftpd
sudo systemctl reload apache2

# Verificación del estado de los servicios
sudo systemctl status vsftpd
sudo systemctl status apache2
