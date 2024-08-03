#!/bin/bash

# Install xclip
sudo dnf install -y xclip

# Generate SSH key
echo "Generating SSH key..."
ssh-keygen -t rsa -b 4096 -C "aydenjmason@gmail.com" -f ~/.ssh/id_rsa -N ""

# Copy SSH key to clipboard
echo "Copying SSH key to clipboard..."
xclip -selection clipboard < ~/.ssh/id_rsa.pub

# Notify user and wait for confirmation
echo "Your new SSH key has been generated and copied to the clipboard."
echo "Please add the SSH key to your GitHub account: https://github.com/settings/keys"
read -p "Press Enter after you have added the SSH key to GitHub..."

# Create and navigate to Repos directory
mkdir -p ~/Documents/Repos
cd ~/Documents/Repos

# Update and install development tools and dependencies
sudo dnf update -y
sudo dnf install -y gcc-c++ cmake git raylib raylib-devel

# Add Visual Studio Code repository and install VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update -y
sudo dnf install -y code

# Verify installations
echo "Verifying installations..."

declare -A packages=(
    [gcc]="gcc --version | head -n 1"
    [gcc-c++]="g++ --version | head -n 1"
    [cmake]="cmake --version | head -n 1"
    [git]="git --version"
    [raylib]="rpm -q raylib raylib-devel"
    [code]="code --version | head -n 1"
)

for pkg in "${!packages[@]}"; do
    if dnf list installed "$pkg" >/dev/null 2>&1; then
        echo -n "${pkg} version: " && eval "${packages[$pkg]}"
    else
        echo "${pkg} is not installed correctly."
    fi
done

# Clone the GitHub repository
git clone git@github.com:aydenmason/scythe.git

# Open the repository in VS Code
code ./
