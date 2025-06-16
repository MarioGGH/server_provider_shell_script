# 🚀 Shell Script para Configuración de Servicios de Proveedor

Este script automatiza la instalación, configuración y activación de servicios esenciales como Apache2 y VSFTPD, incluyendo configuraciones de puertos, firewall y verificación de estado de los servicios.

---

## 📂 1. Paquetes a instalar

Se instalarán los siguientes paquetes:

* `apache2` → servidor web
* `vsftpd` → servidor FTP seguro

---

## 🚪 2. Puertos a abrir

Para asegurar el correcto funcionamiento de los servicios, se deben abrir los siguientes puertos:

* `80` → para Apache2 (HTTP)
* `21` → para VSFTPD (FTP)
* `30000-31000` → para modo pasivo de FTP

---

## ⚙️ 3. Inicialización de servicios

```sh
sudo systemctl start vsftpd
sudo systemctl enable vsftpd
sudo systemctl start apache2
sudo systemctl enable apache2
```

Esto inicia y habilita ambos servicios para que se ejecuten al iniciar el sistema.

---

## 🔧 4. Configuración de VSFTPD

Reemplazamos el archivo de configuración existente por uno nuevo con opciones seguras y funcionales:

```sh
sudo rm /etc/vsftpd.conf
sudo touch /etc/vsftpd.conf

echo "local_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "write_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "chroot_local_user=YES" | sudo tee -a /etc/vsftpd.conf
echo "allow_writable_chroot=YES" | sudo tee -a /etc/vsftpd.conf

# Configuración de escucha y modo pasivo
echo "listen=YES" | sudo tee -a /etc/vsftpd.conf
echo "listen_ipv6=NO" | sudo tee -a /etc/vsftpd.conf

echo "pasv_enable=YES" | sudo tee -a /etc/vsftpd.conf
echo "pasv_min_port=30000" | sudo tee -a /etc/vsftpd.conf
echo "pasv_max_port=31000" | sudo tee -a /etc/vsftpd.conf

# Directorios seguros y rutas personalizadas
echo "secure_chroot_dir=/var/run/vsftpd/empty" | sudo tee -a /etc/vsftpd.conf

echo "listen_address=0.0.0.0" | sudo tee -a /etc/vsftpd.conf

# Rutas basadas en el usuario
echo "user_sub_token=$USER" | sudo tee -a /etc/vsftpd.conf

echo "local_root=/var/www/html/$USER" | sudo tee -a /etc/vsftpd.conf
```

---

## 🛡️ 5. Configuración del firewall

```sh
sudo ufw allow 80/tcp
sudo ufw allow 21/tcp
sudo ufw allow 30000:31000/tcp
```

Esto habilita el tráfico necesario para Apache2 y VSFTPD en modo pasivo.

---

## ↻️ 6. Recargar servicios

```sh
sudo systemctl reload vsftpd
sudo systemctl reload apache2
```

Se recargan ambos servicios para aplicar la configuración actualizada sin reiniciarlos completamente.

---

## 📊 7. Verificación del estado de los servicios

```sh
sudo systemctl status vsftpd
sudo systemctl status apache2
```

Este paso es importante para confirmar que ambos servicios están activos y funcionando correctamente.

---

## ✅ Resultado esperado

Al final de la ejecución del script:

* Apache2 servirá archivos web en el puerto 80.
* VSFTPD permitirá subir archivos por FTP desde el directorio del usuario.
* Todos los puertos necesarios estarán abiertos.
* Los servicios se iniciarán automáticamente en cada reinicio del sistema.

---
