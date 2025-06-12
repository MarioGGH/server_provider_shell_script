# `Shell Script` for proveedor services

## 1. packages to install.
The packages to be installed will be the following.
* _apache2_
* _vsftpd_

## 2. ports to open.
* _port 80 for apache2_
* _port 21 for vsftpd_

## 3. initialization of services
```sh
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2
```

## 4. We configure the vsftpd package.
```sh
sudo rm /etc/vsftpd.conf
sudo touch /etc/vsftpd.conf

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
```

## 4. Firewall configuration.
```sh
sudo ufw allow 80/tcp
sudo ufw allow 21/tcp
sudo ufw allow 30000:31000/tcp
```

## 5. Services are recharged.
```sh
sudo systemctl reload vsftpd
sudo systemctl reload apache2
```

## 6. verification of the status of the services.
```sh
sudo systemctl status vsftpd
sudo systemctl status apache2
```


