#!/bin/bash

# update system
sudo dnf upgrade -y

# deault nautilus view
rm -Rf .local/share/gvfs-metadata
gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
gsettings set org.gnome.nautilus.preferences show-hidden-files true

# install oh-my-zsh
sudo dnf install -y vim fontawesome-fonts powerline tmux-powerline powerline-fonts curl git zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/^plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g" ~/.zshrc
sed -i "s/^ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"agnoster\"/g" ~/.zshrc

# install coding tools
sudo dnf -y groupinstall "Development Tools"
sudo dnf install -y gcc-g++ cmake make git

# install code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code -y

# install dislocker (windows encrypted drives)
sudo dnf install -y mbedtls-devel fuse-devel
git clone git@github.com:Aorimn/dislocker.git && cd dislocker && mkdir build && cd build && cmake .. && cmake --build . && sudo cmake --build . --target install
sudo mkdir /media/bitlocker
