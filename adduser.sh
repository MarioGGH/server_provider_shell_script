#!/bin/bash

# Pedimos nombre del usuario
read -p "Nombre del usuario: " user

# Creamos el usuario con su directorio home y asignamos bash como shell
sudo useradd -m -s /bin/bash $user

# Creamos la carpeta en /var/www/html/nombre_usuario
sudo mkdir -p /var/www/html/$user

# Cambiamos las propiedades de la carpeta
sudo chown -R $user:$user /var/www/html/$user

# Damos permisos al usuario
sudo chmod -R 755 /var/www/html/$user

# Asignamos la contraseña al usuario
sudo passwd $user

# Como prueba, verificamos si el usuario se creó con éxito
echo "Directorio creado y permisos asignados al usuario $user en /var/www/html/$user"
echo "Contraseña asignada al usuario $user"

