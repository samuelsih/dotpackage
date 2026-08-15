#!/usr/bin/env bash
set -e

DOTPACKAGE_REPO="${DOTPACKAGE_REPO:-https://github.com/sxavity/dotpackage.git}"

function detect_os {
  [[ -f /etc/os-release ]] && source /etc/os-release && echo "$ID" || echo "unknown"
}

function install_ansible {
  case $1 in
  arch)
    sudo pacman -S --noconfirm ansible
    ;;
  ubuntu)
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt-get install -y ansible
    ;;
  fedora)
    sudo dnf install -y ansible
    ;;
  *)
    echo "Unsupported OS: $1"
    echo "Supported OS: arch, ubuntu, fedora"
    exit 1
    ;;
  esac
}

function clone_dotpackage {
  if [[ -d "$HOME/dotpackage" ]]; then
    echo "dotpackage already cloned at $HOME/dotpackage"
    cd "$HOME/dotpackage"
    git pull --quiet
  else
    echo "Cloning dotpackage from $DOTPACKAGE_REPO"
    git clone "$DOTPACKAGE_REPO" "$HOME/dotpackage"
    cd "$HOME/dotpackage"
  fi
}

function install_collections {
  ansible-galaxy collection install -r ansible/requirements.yaml
}

function run_playbook {
  (cd ansible && ansible-playbook main.yaml --ask-become-pass --ask-vault-pass)
}

os=$(detect_os)
echo "Detected OS: $os"

echo "Installing ansible"
install_ansible "$os"

echo "Cloning the dotpackage"
clone_dotpackage

echo "Installing ansible collections"
install_collections

echo "Running ansible playbook"
run_playbook

echo "Stowify config"
stow -t ~ zsh
stow .
