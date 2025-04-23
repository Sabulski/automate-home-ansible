#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

# Update Linux servers
ansible-playbook -i inventory.yml update-linux-servers.yml --vault-password-file .vault_pass

# Update OpenWRT routers
ansible-playbook -i inventory.yml update-openwrt-routers.yml --vault-password-file .vault_pass
