#!/bin/bash

# Path to the CSV file with usernames and passwords
CSV_FILE="user.csv"

# Read the CSV file line by line
while IFS=, read -r user password; do
    # Check that the line is not empty
    if [ -z "$user" ] || [ -z "$password" ]; then
        continue
    fi

    # Create the user
    sudo useradd -s /bin/bash -d /var/www/html/$user $user

    # Create the folder in /var/www/html/$user
    sudo mkdir -p /var/www/html/$user/uploads

    # Change ownership of the folder
    sudo chown -R $user:$user /var/www/html/$user
    sudo chown -R $user:$user /var/www/html/$user/uploads

    # Set permissions for the user
    sudo chmod a-w /var/www/html/$user
    sudo chmod -R 755 /var/www/html/$user/uploads

    # Assign the password to the user
    echo "$user:$password" | sudo chpasswd

    # For verification, check if the user was created successfully
    echo "Directory created and permissions assigned to user $user at /var/www/html/$user"
    echo "Password assigned to user $user"
done < "$CSV_FILE"
