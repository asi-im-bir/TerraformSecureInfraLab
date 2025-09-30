**Compute Overview**

The compute module provisions compute resources for the Secure Cloud Infra project.
It includes:

Bastion VM in the public subnet (for secure SSH/RDP access).
Private VM in the private subnet (no public IP, accessible only via Bastion).
System-assigned Managed Identities enabled for both VMs.

**Inputs**

| Name | Type	| Description	| Example |
| --- | --- | --- | --- |
resource_group | string	| The name of the resource group where VMs live	| rg-terraform-securelab
location | string	| Azure region for resources | westeurope
public_subnet_id | string	| ID of the public subnet for the bastion VM	| -
private_subnet_id	| string	| ID of the private subnet for the private VM | -

**Outputs**

| Name | Description | Example |
| --- | --- | --- |
bastion_vm_ip	| Public IP of the Bastion VM | 20.16.122.210
bastion_vm_principal_id | Principal ID of Bastion VM’s managed identity	| 11111111-2222-3333-4444-555555555555
private_vm_principal_id | Principal ID of Private VM’s managed identity | 66666666-7777-8888-9999-000000000000

Usage Example (from root)
module "compute" {
  source              = "./modules/compute"
  resource_group      = azurerm_resource_group.rg.name
  location            = var.resource_group_location
  public_subnet_id    = module.network.public_subnet_id
  private_subnet_id   = module.network.private_subnet_id
}

**Additional Notes**

Bastion VM is the secure entry point — no direct access is allowed to the private VM.
Both VMs use Managed Identities, assigned access to Key Vault or later to other Azure resources.
Private VM has no public IP to minimize attack surface.
