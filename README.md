# 🌩️ Terraform Secure Infrastructure Lab — Azure Key Vault Security

## 📘 Project Overview

This project demonstrates a **secure, cost-optimized Azure infrastructure** built with **Terraform Infrastructure as Code (IaC)**.  
The focus was on implementing **defense-in-depth**, **least privilege**, and **separation of duties** principles using **Azure Key Vault**, **Managed Identities**, and **modular Terraform design**.

The solution aligns with the **Azure Well-Architected Framework**, particularly the **Security**, **Reliability**, and **Cost Optimization** pillars.

--
## 🏗️ Technical Architecture Diagram

```text
                        ┌─────────────────────────────────────┐
                        │           Azure Cloud               │
                        │─────────────────────────────────────│
                        │                                     │
                        │    ┌────────────────────────────┐    │
   Internet  ───────────▶    │     Public Subnet (DMZ)    │    │
                        │    │  10.0.1.0/24               │    │
                        │    │                            │    │
                        │    │  [ Bastion VM ]            │    │
                        │    │   • Public IP              │    │
                        │    │   • SSH from admin IP only │    │
                        │    └─────────────┬──────────────┘    │
                        │                  │ SSH (22)           │
                        │                  ▼                    │
                        │    ┌────────────────────────────┐    │
                        │    │   Private Subnet (App)     │    │
                        │    │  10.0.2.0/24               │    │
                        │    │                            │    │
                        │    │  [ Private VM ]            │    │
                        │    │   • No public IP           │    │
                        │    │   • Managed Identity       │    │
                        │    └─────────────┬──────────────┘    │
                        │                  │                    │
                        │                  ▼                    │
                        │      ┌──────────────────────┐         │
                        │      │   Azure Key Vault    │         │
                        │      │  • Secrets storage   │         │
                        │      │  • Access policies   │         │
                        │      │  • Managed Identity  │         │
                        │      └──────────────────────┘         │
                        │                                     │
                        └─────────────────────────────────────┘
---


🛡️ Security Flow Summary:

Bastion VM = Controlled entry point

Private VM = Application workload (no internet access)

Key Vault = Central secret storage

Managed Identity = Secure credential access without secrets


### **Key Security Patterns**
- **Defense-in-Depth:** Layered network and identity security boundaries  
- **Bastion Host Pattern:** Controlled SSH access through a single hardened entry point  
- **Secret Zero:** No hardcoded credentials — Key Vault + Managed Identity only  
- **Least Privilege:** Each resource has minimal access required  

---

## ⚙️ Tech Stack Utilized

| Category | Technologies |
|-----------|---------------|
| **Cloud Provider** | Microsoft Azure |
| **Infrastructure as Code (IaC)** | Terraform |
| **Security & Identity** | Azure Key Vault, Managed Identities, RBAC, NSGs |
| **Compute & Network** | Azure Virtual Machines, Virtual Network (VNet), Subnets, Bastion Host |
| **Monitoring & Logging** | Azure Monitor, Log Analytics |
| **Development Tools** | Azure CLI, PowerShell, GitHub, VS Code |

---

## 🧠 Problem Statement → Solution

### **Problem**
Organizations often lack a **secure and repeatable way** to deploy cloud environments for development or testing.  
Sensitive data such as passwords and SSH keys are often mismanaged, and network boundaries are inconsistently enforced.

### **Input**
- Terraform configurations defining:
  - Resource group, VNet, subnets, NSGs  
  - Compute instances (bastion + private VM)  
  - Key Vault for secret storage  
  - Access policies for Managed Identities

### **Output**
- Fully provisioned **secure Azure environment** with:
  - Enforced **least privilege** access  
  - Centralized **secret management**  
  - Isolated **public/private subnet design**  
  - Auto-shutdown for cost control  

---

## 🏗️ What I Built

- **Modular Terraform design** separating:
  - 🔹 Network module (VNet, subnets, NSGs)
  - 🔹 Compute module (bastion + private VM)
  - 🔹 Key Vault module (secret management)
  - 🔹 Security configuration module (access policies)

- **Azure Key Vault integration** to store and protect SSHkeys & app secrets.
- **Managed Identities** to eliminate plaintext credentials (Secret Zero principle).
- **Network Security** implementing DMZ pattern with public/private segmentation.
- **Monitoring & logging** via Azure Monitor and Log Analytics.
- **Auto-shutdown and optimized compute SKUs** to reduce cost.

---

## 🔐 Cloud Security Domains Addressed

| Domain | Implementation |
|--------|----------------|
| **Identity & Access Management (IAM)** | Managed Identities, RBAC, Key Vault policies |
| **Network Security** | NSGs, subnet isolation, Bastion host access control |
| **Data Protection** | Key Vault encryption, soft delete, and secret versioning |
| **Operational Security** | Logging, monitoring, and network segmentation |
| **Automation Security** | Terraform ensures secure, consistent infrastructure deployment |

---

## 📚 Lessons Learned

- **Separation of Concerns:** Modular Terraform increases scalability and security.  
- **Principle of Least Privilege:** Minimal “Get” permissions mitigate lateral movement.  
- **Defense-in-Depth:** Combining IAM, Key Vault, and network restrictions ensures layered protection.  
- **Security Testing:** Negative access tests validated IAM and NSG boundaries.  
- **Secret Zero Principle:** Managed Identities eliminate the need for stored credentials.  
- **Cost Awareness:** Balancing security and cost optimization is critical in IaC design.

---

## 💼 Value to Employers

With this project experience, I can:
- Architect and deploy **secure Azure environments** using IaC best practices.  
- Implement **DevSecOps pipelines** that embed security controls early in the SDLC.  
- Apply **Azure security tools** like Key Vault, NSGs, and RBAC to enforce compliance.  
- Conduct **security validation, penetration testing, and remediation**.  
- Implement **continuous compliance** aligned with frameworks such as **ISO 27001**, **NIST CSF**, and **CIS Controls**.  

---

## 🧩 Future Contributions as a DevSecOps & Security GRC Engineer

Building on this project, I can help organizations advance their **DevSecOps maturity** and **governance posture** by:

- **Automating Security Compliance:**  
  Integrating Terraform with Azure Policy, Sentinel, and Defender for Cloud to continuously enforce compliance across resources.

- **Embedding GRC in CI/CD Pipelines:**  
  Incorporating compliance-as-code and security testing tools (e.g., Checkov, tfsec, Trivy) to ensure that every code change meets governance and security baselines.

- **Risk Management & Policy Enforcement:**  
  Mapping Terraform deployments to risk frameworks (ISO 27001, NIST, CIS) to provide traceability between controls and configurations.

- **Vulnerability & Secrets Management:**  
  Integrating Key Vault with DevOps pipelines to securely inject secrets during runtime and avoid credential exposure in workflows.

- **Incident Response Readiness:**  
  Using Azure Monitor and Log Analytics data to detect anomalies, audit changes, and support compliance reporting.

- **GRC Dashboards & Reporting:**  
  Producing compliance dashboards using Azure Monitor, Power BI, or Sentinel to provide real-time visibility into cloud posture.

This knowledge enables me to bridge **technical security automation** with **strategic governance**, helping companies achieve both **secure innovation** and **regulatory compliance**.

---

## 🔮 Potential Future Enhancements

- Integrate with **Azure DevOps** or **GitHub Actions** for CI/CD Terraform automation.  
- Implement **Azure Policy-as-Code** for compliance enforcement.  
- Extend Key Vault to use **RBAC-based authorization** instead of access policies.  
- Add **Private Endpoints** for Key Vault and Storage for full network isolation.  
- Incorporate **Azure Sentinel** for SIEM-based monitoring.  
- Expand to **multi-region deployments** with redundancy and disaster recovery.  

---

## 📄 Documentation

- [🔑 Azure Key Vault Module Overview (PDF)](docs/ReadMe_KeyVault_Modules.pdf)  
- [🧪 Secure Deployment, Testing & Troubleshooting (PDF)](docs/KeyVault_Security_Demo.pdf)

---

## 🧰 How to Use

1. Clone the repository  
   ```bash
   git clone https://github.com/asi-im-bir/TerraformSecureInfraLab.git
   cd TerraformSecureInfraLab
Configure your variables in:

terraform.tfvars (local, private)

or copy and edit the public template:

bash
Copy code
cp terraform.tfvars.example terraform.tfvars
Initialize and deploy:

bash
Copy code
terraform init
terraform plan
terraform apply
Author: asi-im-bir
Focus: Secure Infrastructure as Code | Azure Cloud Security | DevSecOps | GRC Automation


# Terraform Secure Infra Lab General
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

**Purpose:** Deploys hardened Linux VMs with security configurations

**Resources Created:**

- TLS private key (4096-bit RSA)
- Public IP (Standard SKU due to Basic limitations)
- Network interfaces with NSG associations
- Bastion VM (Ubuntu 22.04 LTS)
- Private VM (Ubuntu 22.04 LTS)
- Azure Monitor extensions
- Auto-shutdown schedules (7 PM UTC)

**Security Hardening Implementation:**

Used cloud-config for reliable package installation:

```yaml
#cloud-config
packages:
  - ufw
  - fail2ban
  - unattended-upgrades
runcmd:
  - Configure firewall rules
  - Enable fail2ban
  - Harden SSH configuration
  - Install Azure CLI from Microsoft repository
```

**Additional Notes**

Bastion VM is the secure entry point — no direct access is allowed to the private VM.
Both VMs use Managed Identities, assigned access to Key Vault or later to other Azure resources.
Private VM has no public IP to minimize attack surface.

------------------------------------------------------------------------------------------------------------------------
### Key Vault Module
**Purpose:** Centralized secrets management

**Resources Created:**

- Azure Key Vault (Standard SKU)
- Access policies for user and VMs
- Diagnostic settings for audit logging

**Configuration:**

```hcl
purge_protection_enabled = false  # For dev/test environments
soft_delete_retention_days = 7
enable_rbac_authorization = false  # Using access policies

secret_permissions = ["Get", "List", "Set", "Delete", "Purge", "Recover"]
```
-------------------------------------------------------------------------------------------------------------------------

### Security Module

**Purpose:** Implements RBAC and secret storage

**Resources Created:**

- Key Vault secrets (database password)
- Access policies for VM managed identities

**RBAC Implementation:**

- Private VM: Get permission only for secrets
- Principle of least privilege enforced

-------------------------------------------------------------------------------------------------------------------------
### Network Module

**Purpose:** Establishes network foundation with security boundaries

**Resources Created:**

- Virtual Network (10.0.0.0/16)
- Public Subnet (10.0.1.0/24) with service endpoints
- Private Subnet (10.0.2.0/24) with service endpoints
- Network Security Groups with rules
- NSG-to-subnet associations

**Security Rules Implemented:**

**Public Subnet NSG:**

```
Inbound:
  - Allow SSH (22) from admin_source_ip only (Priority: 100)
  - Deny all other inbound (Priority: 4096)
Outbound:
  - Allow HTTPS (443)
  - Allow HTTP (80)
  - Allow DNS (53)
  - Allow SSH to private subnet
```

**Private Subnet NSG:**

```
Inbound:
  - Allow SSH from VirtualNetwork (Priority: 200)
  - Deny all other inbound (Priority: 4096)
Outbound:
  - Allow HTTPS/HTTP/DNS for updates
```

-------------------------------------------------------------------------------------------------------------------------
## Security Measures Implemented

1. **Network Segmentation**: Public/private subnet isolation
2. **Bastion Host Pattern**: Single hardened entry point
3. **NSG Rules**: Explicit deny-all with specific allows
4. **No Public IPs**: Private resources have no direct internet exposure
5. **Managed Identities**: No hardcoded credentials
6. **SSH Key Authentication**: Password authentication disabled
7. **Automated Security Updates**: Unattended-upgrades configured
8. **Fail2ban**: Brute force protection
9. **UFW Firewall**: Host-level protection
10. **Audit Logging**: Key Vault access logging

## Cost Optimizations

- **VM SKU**: Standard_B1s (eligible for free tier - 750 hours/month)
- **Storage**: Standard_LRS (lower cost than Premium)
- **Public IP**: Standard SKU (Basic had limitations)
- **Auto-shutdown**: 7 PM UTC daily
- **Monitoring**: Free tier limits respected

**Estimated Monthly Cost**: ~$15-20 (with auto-shutdown enabled)
