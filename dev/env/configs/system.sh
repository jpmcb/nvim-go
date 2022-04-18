#!/bin/bash

apt update
apt-get update

# Get latest stable version of neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv ./nvim.appimage /usr/local/bin/nvim

# Install golang 1.17
wget https://dl.google.com/go/go1.17.6.linux-amd64.tar.gz
tar -C /usr/local/ -xzvf go1.17.6.linux-amd64.tar.gz

cat >> "${HOME}/.bashrc" << EOF
# Append path with go bins
export PATH=$PATH:/usr/local/go/bin
export GOBIN=/usr/loca/go/bin
EOF

# Setup packer and get repository
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Setup nvim config structure
mkdir -p "${HOME}/.config/nvim/"
