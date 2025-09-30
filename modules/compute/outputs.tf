output "bastion_public_ip" {
  description = "Public IP address of the bastion VM"
  value       = azurerm_public_ip.bastion_ip.ip_address
}

output "bastion_private_id" {
  description = "The ID of the private Bastion VM"
  value = azurerm_linux_virtual_machine.private_vm.id
}

output "private_vm_private_ip" {
  description = "Private IP of the private VM"
  value       = azurerm_network_interface.private_nic.private_ip_address
}

output "bastion_vm_id" {
  description = "Resource ID of the bastion VM"
  value       = azurerm_linux_virtual_machine.bastion.id
}

output "private_vm_id" {
  description = "Resource ID of the private VM"
  value       = azurerm_linux_virtual_machine.private_vm.id
}

output "bastion_vm_principal_id" {
  description = "Principal ID of the bastion VM managed identity"
  value = azurerm_linux_virtual_machine.bastion.identity[0].principal_id
}

output "private_vm_principal_id" {
  description = "Principal ID of the private VM managed identity"
  value = azurerm_linux_virtual_machine.private_vm.identity[0].principal_id
}

output "ssh_private_key" {
  description = "SSH private key for VM access"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

output "ssh_public_key" {
  description = "SSH public key"
  value       = tls_private_key.ssh_key.public_key_openssh
}