# Automate Home Ansible

This project automates the process of updating Linux servers and OpenWRT routers using Ansible. It ensures all systems are up-to-date with the latest packages and security updates.

## Prerequisites

1. **Ansible Installed**: Ensure Ansible is installed on your control machine.
2. **Inventory Configuration**: The `inventory.yml` file must be configured with the hosts you want to manage. Use the provided `inventory.yml.example` as a template.
3. **Vault File**: A `vault.yml` file must be created to store sensitive variables like passwords securely.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-repo/automate-home-ansible.git # Fixed repository name
cd automate-home-ansible
```

### 2. Create the `vault.yml` File

The `vault.yml` file is used to store sensitive variables securely. Create the file in the project directory with the following structure:

```yaml
ansible_user: <your-ssh-username>
ansible_ssh_pass: <your-ssh-password>
```

Replace `<your-ssh-username>` and `<your-ssh-password>` with the appropriate values for your systems.

### 3. Encrypt the Vault File

Encrypt the `vault.yml` file using Ansible Vault to secure its contents:

```bash
ansible-vault encrypt vault.yml
```

You will be prompted to set a password. Remember this password, as it will be required to run the playbooks.

### 4. Configure the Inventory

Copy the example inventory file and customize it for your environment:

```bash
cp inventory.yml.example inventory.yml
```

Edit `inventory.yml` to include the hosts you want to manage. For example:

```yaml
home_debian_servers:
  hosts:
    server_1:
      ansible_host: 192.168.1.10
      ansible_user: johnny
      ansible_ssh_private_key_file: ~/.ssh/id_rsa
```

### 5. Run the Playbooks

Run the playbooks to update your systems:

#### Update Linux Servers

```bash
ansible-playbook -i inventory.yml update-linux-servers.yml --vault-password-file .vault_pass
```

#### Update OpenWRT Routers

```bash
ansible-playbook -i inventory.yml update-openwrt-routers.yml --vault-password-file .vault_pass
```

## Playbook Details

### `update-linux-servers.yml`

- Updates package caches and upgrades packages for various Linux distributions.
- Reboots servers if required.

### `update-openwrt-routers.yml`

- Updates the package list and upgrades all upgradable packages on OpenWRT routers.

## Notes

- The playbooks use a rolling update strategy (`serial: 25%`) to update systems in batches.
- If more than 10% of the systems fail during the update, the playbooks will stop execution (`max_fail_percentage: 10`).

## Troubleshooting

- Ensure SSH access to the systems is configured correctly.
- Verify the `vault.yml` file contains the correct credentials and is encrypted.
- Check the `inventory.yml` file for correct host configurations.