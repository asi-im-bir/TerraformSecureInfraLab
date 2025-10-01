# Terraform Secure Infra Lab
## Project Overview
![img.png](img.png)
This project implements a secure, cost-optimized Azure infrastructure using Terraform Infrastructure as Code (IaC). The architecture follows Azure
Well-Architected Framework principles with emphasis on security (defense-in-depth) and cost optimization for development/testing environments.

### Architecture Components

- **Virtual Network**: Segmented into public DMZ and private application subnets
- **Compute**: Bastion host (jump server) in public subnet, application VM in private subnet
- **Security**: Network Security Groups with restrictive rules, managed identities, Key Vault for secrets
- **Monitoring**: Azure Monitor agents and Log Analytics integration
- **Cost Controls**: Auto-shutdown schedules, Basic/Standard SKU selection, free tier optimization

## Technical Architecture

```
Azure Subscription
└── Resource Group (rg-terraform-securelab)
    ├── Virtual Network (10.0.0.0/16)
    │   ├── Public Subnet (10.0.1.0/24)
    │   │   ├── Bastion VM (with Public IP)
    │   │   └── NSG (Allow SSH from admin IP only)
    │   └── Private Subnet (10.0.2.0/24)
    │       ├── Application VM (no public IP)
    │       └── NSG (Allow SSH from public subnet only)
    ├── Key Vault
    │   ├── SSH Private Key
    │   └── Database Password Secret
    └── Managed Identities (System-assigned for VMs)
```
## Module Structure

### Root Module Configuration

**Files:**
- `main.tf` - Module orchestration and resource dependencies
- `variables.tf` - Input variable definitions
- `outputs.tf` - Output values for module interconnection
- `providers.tf` - Azure provider configuration
- `terraform.tfvars` - Variable values (gitignored)

**Key Implementations:**
```hcl
# Random suffix for globally unique names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Module dependency chain
# network -> compute -> keyvault -> security
```


-------------------------------------------------------------------------------------------------------------------------

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


