output "vnet_name" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = azurerm_subnet.private.id
}


output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "nsg_public_id" {
  description = "The ID of the public subnet NSG"
  value       = azurerm_network_security_group.nsg_public.id
}

output "nsg_private_id" {
  description = "The ID of the private subnet NSG"
  value       = azurerm_network_security_group.nsg_private.id
}