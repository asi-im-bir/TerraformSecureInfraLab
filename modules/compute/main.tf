#Generate SSH
resource "tls_private_key" "ssh_key" {
    algorithm = "RSA"
    rsa_bits = 4096
}

#Public IP address for Bastion host
resource "azurerm_public_ip" "bastion_ip" {
    name = "${var.vm_prefix}-bastion-pip"
    resource_group_name = var.resource_group_name
    location = var.location
    allocation_method = "Static"
    sku = "Standard" #Standard for Standard SKU and Basic for Basic SKU (free but ip limited)

    tags = merge(
      var.tags,
      {
        Name        = "Bastion Public IP"
        Environment = var.environment
        ManagedBy   = "Terraform"
      }
    )
}

#Network Interface for the Bastion
resource "azurerm_network_interface" "bastion_nic" {
    name = "${var.vm_prefix}-bastion-nic"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.public_subnet_id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.bastion_ip.id
    }

    tags = var.tags
}

#Associate Bastion NIC with NSG (if passed)
resource "azurerm_network_interface_security_group_association" "bastion_nsg" {
  count                     = var.public_nsg_id != "" ? 1 : 0
  network_interface_id      = azurerm_network_interface.bastion_nic.id
  network_security_group_id = var.public_nsg_id
}

resource "azurerm_linux_virtual_machine" "bastion" {
    name = "${var.vm_prefix}-bastion-vm"
    resource_group_name = var.resource_group_name
    location = var.location
    size = var.vm_size

    admin_username                  = var.admin_username
    disable_password_authentication = true

    network_interface_ids = [
        azurerm_network_interface.bastion_nic.id
    ]

    admin_ssh_key {
        username = var.admin_username
        public_key = tls_private_key.ssh_key.public_key_openssh
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts-gen2"
        version = "latest"
    }

    identity {
        type = "SystemAssigned"
    }

    #Security hardening script
    custom_data = base64encode(<<-EOF
  #cloud-config
  package_update: true
  package_upgrade: false
  packages:
    - ufw
    - fail2ban
    - unattended-upgrades
    - jq
    - ca-certificates
    - curl
    - apt-transport-https
    - lsb-release
    - gnupg

  runcmd:
    # Add Azure CLI repository
    - curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
    - echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
    - apt-get update
    - apt-get install -y azure-cli

    # Configure firewall
    - ufw --force enable
    - ufw default deny incoming
    - ufw default allow outgoing
    - ufw allow 22/tcp
    - ufw reload

    # Configure fail2ban
    - |
      cat > /etc/fail2ban/jail.local <<'FAIL2BAN'
      [sshd]
      enabled = true
      port = 22
      filter = sshd
      logpath = /var/log/auth.log
      maxretry = 3
      bantime = 3600
      findtime = 600
      FAIL2BAN
    - systemctl enable fail2ban
    - systemctl restart fail2ban

    # Harden SSH
    - sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
    - sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
    - systemctl restart sshd

    # Create Key Vault access script
    - |
      cat > /usr/local/bin/get-secret.sh <<'SCRIPT'
      #!/bin/bash
      SECRET_NAME=$$1
      KV_NAME=${var.key_vault_name}
      az login --identity --allow-no-subscriptions 2>/dev/null
      az keyvault secret show --vault-name $$KV_NAME --name $$SECRET_NAME --query value -o tsv
      SCRIPT
    - chmod +x /usr/local/bin/get-secret.sh

    # Set MOTD
    - |
      cat > /etc/motd <<'MOTD'
      #############################################################
      #                   AUTHORIZED ACCESS ONLY                 #
      #  All actions are logged and monitored.                   #
      #############################################################
      Environment: ${var.admin_username}
      Managed by: Terraform
      MOTD
  EOF
  )

    boot_diagnostics {
      storage_account_uri = null  # Use managed storage account
    }

    tags = merge(
      var.tags,
      {
        Name        = "Bastion Host"
        Role        = "Jump Server"
        Environment = var.environment
        ManagedBy   = "Terraform"
        AutoShutdown = "Enabled"
      }
    )
}

resource "azurerm_network_interface" "private_nic" {
    name = "${var.vm_prefix}-private-nic"
    location = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name = "internal"
        subnet_id = var.private_subnet_id
        private_ip_address_allocation = "Dynamic"
    }

    tags = var.tags
}

#Associate Private NIC with NSG
resource "azurerm_network_interface_security_group_association" "private_nsg" {
  count                     = var.private_nsg_id != "" ? 1 : 0
  network_interface_id      = azurerm_network_interface.private_nic.id
  network_security_group_id = var.private_nsg_id
}

resource "azurerm_linux_virtual_machine" "private_vm" {
    name = "${var.vm_prefix}-private-vm"
    resource_group_name = var.resource_group_name
    location = var.location
    size = var.vm_size

    admin_username                  = var.admin_username
    disable_password_authentication = true

    network_interface_ids = [
        azurerm_network_interface.private_nic.id
    ]

    admin_ssh_key {
        username = var.admin_username
        public_key = tls_private_key.ssh_key.public_key_openssh
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
        disk_size_gb         = 30
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts-gen2"
        version = "latest"
    }

    identity {
        type = "SystemAssigned"
    }

    custom_data = base64encode(templatefile("${path.module}/scripts/vm_hardening.sh", {
      admin_username = var.admin_username
      key_vault_name = var.key_vault_name
    }))

    boot_diagnostics {
      storage_account_uri = null
    }

    tags = merge(
      var.tags,
      {
        Name        = "Private Application VM"
        Role        = "Application Server"
        Environment = var.environment
        ManagedBy   = "Terraform"
        AutoShutdown = "Enabled"
      }
    )
}

#VM monitoring extension for Bastion
resource "azurerm_virtual_machine_extension" "bastion_monitor" {
  count                = var.enable_monitoring ? 1 : 0
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.bastion.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true

  tags = var.tags
}

#VM monitoring extension for private
resource "azurerm_virtual_machine_extension" "private_monitor" {
  count                = var.enable_monitoring ? 1 : 0
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.private_vm.id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true

  tags = var.tags
}

#Auto-Shutdown Schedule (Cost Optimization)
resource "azurerm_dev_test_global_vm_shutdown_schedule" "bastion_shutdown" {
  count              = var.enable_auto_shutdown ? 1 : 0
  virtual_machine_id = azurerm_linux_virtual_machine.bastion.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = var.auto_shutdown_time
  timezone              = var.auto_shutdown_timezone

  notification_settings {
    enabled = false
  }

  tags = var.tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "private_shutdown" {
  count              = var.enable_auto_shutdown ? 1 : 0
  virtual_machine_id = azurerm_linux_virtual_machine.private_vm.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = var.auto_shutdown_time
  timezone              = var.auto_shutdown_timezone

  notification_settings {
    enabled = false
  }

  tags = var.tags
}