resource_group_name     = "rg-terraform-securelab"
resource_group_location = "westeurope"

vnet_cidr           = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

# 👇 Replace with your actual public IP TODO
allowed_admin_cidr = "78.29.192.45/32"

enable_rdp_rule = false