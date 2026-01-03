#!/usr/bin/env bash

set -e

echo "[*] Starting gooprecon prerequisite installation..."

OS=$(uname -s)

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_go() {
  if command_exists go; then
    echo "[+] Go already installed"
  else
    echo "[*] Installing Go..."
    if [[ "$OS" == "Linux" ]]; then
      sudo apt update
      sudo apt install -y golang
    elif [[ "$OS" == "Darwin" ]]; then
      brew install go
    fi
  fi
}

install_basic_packages() {
  echo "[*] Installing basic dependencies..."
  if [[ "$OS" == "Linux" ]]; then
    sudo apt update
    sudo apt install -y \
      git \
      curl \
      wget \
      nmap \
      nikto \
      ruby \
      ruby-dev \
      build-essential \
      unzip
  elif [[ "$OS" == "Darwin" ]]; then
    brew install git curl wget nmap nikto ruby unzip
  fi
}

install_go_tools() {
  echo "[*] Installing Go-based recon tools..."

  go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
  go install github.com/projectdiscovery/httpx/cmd/httpx@latest
  go install github.com/lc/gau/v2/cmd/gau@latest
  go install github.com/tomnomnom/assetfinder@latest
  go install github.com/tomnomnom/uro@latest
  go install github.com/ffuf/ffuf@latest
}

install_wpscan() {
  if command_exists wpscan; then
    echo "[+] WPScan already installed"
  else
    echo "[*] Installing WPScan..."
    sudo gem install wpscan
  fi
}

setup_go_path() {
  if ! grep -q "GOPATH" ~/.bashrc 2>/dev/null; then
    echo "[*] Configuring GOPATH..."
    echo 'export GOPATH=$HOME/go' >> ~/.bashrc
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
  fi
}

verify_installation() {
  echo
  echo "[*] Verifying installed tools..."
  tools=(
    subfinder
    assetfinder
    httpx
    gau
    uro
    ffuf
    nmap
    nikto
    wpscan
  )

  for tool in "${tools[@]}"; do
    if command_exists "$tool"; then
      echo "[✔] $tool installed"
    else
      echo "[✘] $tool NOT installed"
    fi
  done
}

main() {
  install_basic_packages
  install_go
  setup_go_path
  install_go_tools
  install_wpscan
  verify_installation

  echo
  echo "[✔] All gooprecon prerequisites installed successfully!"
  echo "[*] Restart your terminal or run: source ~/.bashrc"
}

main
