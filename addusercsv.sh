#!/bin/bash

# Ruta al archivo CSV con usuarios y contraseñas
CSV_FILE="user.csv"

# Leemos el archivo CSV línea por línea
while IFS=, read -r user password; do
    # Verificamos que la línea no esté vacía
    if [ -z "$user" ] || [ -z "$password" ]; then
        continue
    fi

    # Creamos el usuario
    sudo useradd -s /bin/bash -d /var/www/html/$user $user

    # Creamos la carpeta en /var/www/html/$user
    sudo mkdir -p /var/www/html/$user/uploads

    # Cambiamos las propiedades de la carpeta
    sudo chown -R $user:$user /var/www/html/$user
    sudo chown -R $user:$user /var/www/html/$user/uploads

    # Damos permisos al usuario
    sudo chmod a-w /var/www/html/$user
    sudo chmod -R 755 /var/www/html/$user/uploads

    # Asignamos la contraseña al usuario
    echo "$user:$password" | sudo chpasswd

    # Como prueba, verificamos si el usuario se creó con éxito
    echo "Directorio creado y permisos asignados al usuario $user en /var/www/html/$user"
    echo "Contraseña asignada al usuario $user"
done < "$CSV_FILE"
