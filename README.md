
# 🚀 Shell Script for Provider Services Setup

Automate the installation, configuration, and management of essential services like Apache2 and VSFTPD, along with user creation scripts.

---

## 📋 Table of Contents

- [📦 Required Packages](#-required-packages)
- [🌐 Ports to Open](#-ports-to-open)
- [⚙️ Service Initialization](#-service-initialization)
- [🔧 VSFTPD Configuration](#-vsftpd-configuration)
- [🛡️ Firewall Setup](#-firewall-setup)
- [🔄 Reloading Services](#-reloading-services)
- [📊 Verifying Service Status](#-verifying-service-status)
- [👤 User Creation Script (Manual)](#-user-creation-script-manual)
- [📁 User Creation Script (From CSV)](#-user-creation-script-from-csv)

---

## 📦 Required Packages

Install these essential packages:

- `apache2` — Web Server  
- `vsftpd` — Secure FTP Server  

---

## 🌐 Ports to Open

Ensure these ports are open for proper service communication:

- **80** — HTTP (Apache2)  
- **21** — FTP (VSFTPD)  
- **30000-31000** — Passive FTP Ports (VSFTPD)  

---

## ⚙️ Service Initialization

Start and enable services at boot:

```bash
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2
```

---

## 🔧 VSFTPD Configuration

Replace the default config with the following secure setup:

```bash
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

---

## 🛡️ Firewall Setup

Allow necessary ports through the firewall:

```bash
sudo ufw allow 80/tcp
sudo ufw allow 21/tcp
sudo ufw allow 30000:31000/tcp
```

---

## 🔄 Reloading Services

Apply configuration changes without restarting:

```bash
sudo systemctl reload vsftpd
sudo systemctl reload apache2
```

---

## 📊 Verifying Service Status

Check if services are running correctly:

```bash
sudo systemctl status vsftpd
sudo systemctl status apache2
```

---

## 👤 User Creation Script (Manual)

Create a new user and set permissions:

```bash
#!/bin/bash

# Ask for username
read -p "Enter username: " user

# Create user with bash shell and home directory
sudo useradd -s /bin/bash -d /var/www/html/$user $user

# Create user directories
sudo mkdir -p /var/www/html/$user/uploads

# Change ownership
sudo chown -R $user:$user /var/www/html/$user
sudo chown -R $user:$user /var/www/html/$user/uploads

# Set permissions
sudo chmod a-w /var/www/html/$user
sudo chmod -R 755 /var/www/html/$user/uploads

# Set password for user
sudo passwd $user

# Confirmation message
echo "✅ Directory and permissions set for user $user at /var/www/html/$user"
echo "🔑 Password assigned for user $user"
```

---

## 📁 User Creation Script (From CSV)

Batch create users from a CSV file (`user.csv`) with format: `username,password`

```bash
#!/bin/bash

CSV_FILE="user.csv"

while IFS=, read -r user password; do
    # Skip empty lines
    if [ -z "$user" ] || [ -z "$password" ]; then
        continue
    fi

    sudo useradd -s /bin/bash -d /var/www/html/$user $user
    sudo mkdir -p /var/www/html/$user/uploads
    sudo chown -R $user:$user /var/www/html/$user
    sudo chown -R $user:$user /var/www/html/$user/uploads
    sudo chmod a-w /var/www/html/$user
    sudo chmod -R 755 /var/www/html/$user/uploads
    echo "$user:$password" | sudo chpasswd

    echo "✅ User $user created with directory and password assigned."
done < "$CSV_FILE"
```

---

## 🎉 Final Notes

- Apache2 will serve files on port 80.  
- VSFTPD allows FTP uploads with secure, user-isolated directories.  
- Firewall ports are configured for service access.  
- Services start automatically at boot.

Feel free to customize the scripts based on your environment and requirements!
