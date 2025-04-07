#!/bin/bash

# Este script eliminará todos los usuarios en el sistema, excepto el usuario 'mint', 
# y eliminará sus directorios en /var/www/html/

# Verificar si se está ejecutando como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root."
    exit 1
fi

# Obtener la lista de usuarios en el sistema, excluyendo 'mint' y 'root'
usuarios=$(cut -d: -f1 /etc/passwd | grep -vE '^(mint|root)$')

# Borrar cada usuario
for usuario in $usuarios; do
    echo "Eliminando usuario: $usuario"
    
    # Eliminar el directorio del usuario en /var/www/html/
    if [ -d "/var/www/html/$usuario" ]; then
        echo "Eliminando directorio de /var/www/html/$usuario"
        rm -rf "/var/www/html/$usuario"
    fi

    # Eliminar el usuario y su directorio home
    userdel -r $usuario
done

echo "Proceso completado."

