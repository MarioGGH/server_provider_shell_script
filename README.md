# 🚀 Shell Script for Provider Services Setup

This script automates the installation, configuration, and activation of essential services such as Apache2 and VSFTPD. It includes port configuration, firewall rules, and service status checks.

---

## 📂 1. Packages to Install

The following packages will be installed:

* `apache2` → Web server
* `vsftpd` → Secure FTP server

---

## 🚪 2. Ports to Open

To ensure proper functionality of the services, the following ports must be opened:

* `80` → for Apache2 (HTTP)
* `21` → for VSFTPD (FTP)
* `30000-31000` → for FTP passive mode

---

## ⚙️ 3. Service Initialization

```sh
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2
```

This starts and enables both services to run at system boot.

---

## 🔧 4. VSFTPD Configuration

Replace the existing configuration file with a new one that includes secure and functional options:

```sh
sudo rm /etc/vsftpd.conf
sudo touch /etc/vsftpd.conf

echo "local_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "chroot_local_user=YES" | sudo tee -a /etc/vsftpd.conf
echo "allow_writable_chroot=YES" | sudo tee -a /etc/vsftpd.conf

# Listening and passive mode

echo "listen=YES" | sudo tee -a /etc/vsftpd.conf
echo "listen_ipv6=NO" | sudo tee -a /etc/vsftpd.conf

echo "pasv_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "pasv_min_port=30000" | sudo tee -a /etc/vsftpd.conf
echo "pasv_max_port=31000" | sudo tee -a /etc/vsftpd.conf

# Secure directories and custom paths

echo "secure_chroot_dir=/var/run/vsftpd/empty" | sudo tee -a /etc/vsftpd.conf
echo "listen_address=0.0.0.0" | sudo tee -a /etc/vsftpd.conf

echo "user_sub_token=$USER" | sudo tee -a /etc/vsftpd.conf
echo "local_root=/var/www/html/$USER" | sudo tee -a /etc/vsftpd.conf
```

---

## 🛡️ 5. Firewall Configuration

```sh
sudo ufw allow 80/tcp
sudo ufw allow 21/tcp
sudo ufw allow 30000:31000/tcp
```

This allows necessary traffic for Apache2 and VSFTPD in passive mode.

---

## ↻️ 6. Reload Services

```sh
sudo systemctl reload vsftpd
sudo systemctl reload apache2
```

Reload the services to apply the new configuration without restarting them entirely.

---

## 📊 7. Check Service Status

```sh
sudo systemctl status vsftpd
sudo systemctl status apache2
```

This step ensures that both services are running correctly.

---

## ✅ Expected Outcome

At the end of script execution:

* Apache2 will serve web files on port 80.
* VSFTPD will allow FTP uploads from the user directory.
* All necessary ports will be open.
* Services will automatically start on system boot.

---
