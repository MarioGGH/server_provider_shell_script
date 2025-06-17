#!/bin/bash

# This script will delete all users on the system except the 'mint' user,
# and remove their directories in /var/www/html/

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

# Get the list of users on the system, excluding 'mint' and 'root'
users=$(cut -d: -f1 /etc/passwd | grep -vE '^(mint|root)$')

# Delete each user
for user in $users; do
    echo "Deleting user: $user"
    
    # Remove the user's directory in /var/www/html/
    if [ -d "/var/www/html/$user" ]; then
        echo "Removing directory /var/www/html/$user"
        rm -rf "/var/www/html/$user"
    fi

    # Delete the user and their home directory
    userdel -r $user
done

echo "Process completed."
