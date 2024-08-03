#!/bin/bash
echo "Generating SSH key..."
ssh-keygen -t rsa -b 4096 -C "aydenjmason@gmail.com" -f ~/.ssh/id_rsa -N ""
echo "Copying SSH key to clipboard..."
xclip -selection clipboard < ~/.ssh/id_rsa.pub
echo "Verifying installations..."
echo -n "gcc version: " && gcc --version | head -n 1
echo -n "g++ version: " && g++ --version | head -n 1
echo -n "cmake version: " && cmake --version | head -n 1
echo -n "git version: " && git --version
echo -n "raylib version: " && rpm -q raylib raylib-devel
echo -n "Visual Studio Code version: " && code --version | head -n 1
echo "All required packages installed and verified successfully."
echo "Your new SSH key has been generated and copied to the clipboard. Add it to your GitHub account."
cd /Documents/
mdkir Repos
cd /Repos/
git clone git@github.com:aydenmason/scythe.git
code ./



sudo dnf update -y
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y gcc-c++ cmake
sudo dnf install -y git
sudo dnf install -y raylib raylib-devel
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update -y
sudo dnf install -y code
sudo dnf install -y xclip
