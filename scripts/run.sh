#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Check if required files exist
if [[ ! -f ../inventory.yml ]]; then
  echo "Error: inventory.yml file not found!"
  exit 1
fi

if [[ ! -f ../.vault_pass ]]; then
  echo "Error: .vault_pass file not found!"
  exit 1
fi

# Update Linux servers
ansible-playbook -i ../inventory.yml ../update-linux-servers.yml --vault-password-file ../.vault_pass

# Update OpenWRT routers
ansible-playbook -i ../inventory.yml ../update-openwrt-routers.yml --vault-password-file ../.vault_pass
