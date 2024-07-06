#!/bin/bash

username="devops"
password="password"

# Create the user if it doesn't exist
if ! id "$username" &>/dev/null; then
    sudo useradd -m -s /bin/bash "$username"
    echo "$username:$password" | sudo chpasswd
    echo "$username ALL=(ALL:ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/"$username"
fi

# Enable SSH password authentication
sudo sed -i 's/^PasswordAuthentication\s*no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication\s*no/PasswordAuthentication yes/' /etc/ssh/sshd_config.d/60-cloudimg-settings.conf
sudo systemctl restart sshd

echo "User $username created with password, full sudo permissions, and SSH login setup."
