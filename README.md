# 🌩️ Terraform Secure Infrastructure Lab  
### Azure Key Vault Security | Defense-in-Depth Cloud Architecture

> **A Terraform-based Azure infrastructure lab** demonstrating secure-by-design principles — built with **defense-in-depth**, **least privilege**, and **separation of duties**.  
> Implements **Azure Key Vault**, **Managed Identities**, and **modular IaC** patterns aligned with the **Azure Well-Architected Framework** (Security, Reliability, and Cost Optimization pillars).

## 🏗️ Technical Architecture

             

🔐 Security Flow Summary
Component	Role	Key Security Controls
Bastion VM	Secure entry point	Public IP restricted to admin source IP; SSH only
Private VM	Application workload	No public IP; accesses Key Vault via Managed Identity
Azure Key Vault	Secrets management	Centralized credentials storage; Key & Secret access via RBAC
Managed Identity	Credential access	Eliminates plaintext secrets in code; direct AAD token-based access
NSGs	Network perimeter defense	Explicit allow/deny inbound/outbound rules
Azure Monitor	Logging & telemetry	Collects logs and metrics from Bastion & Private VMs
## 🧱 Project Summary

**Goal:**  
Build a **secure, cost-optimized Azure environment** for Dev/Test workloads using **Terraform IaC**, eliminating manual key management and enforcing least privilege.

**Core Security Concepts**
- 🧩 *Defense-in-Depth:* Network segmentation + IAM + Key Vault  
- 🔐 *Secret Zero:* No hardcoded credentials — all secrets from Key Vault  
- 🧱 *Bastion Host Pattern:* Secure SSH entry through a hardened DMZ  
- ⚙️ *Automation:* Modular Terraform for repeatable, compliant deployments  

---

## ⚙️ Tech Stack

| Category | Technologies |
|-----------|--------------|
| **Cloud Provider** | Microsoft Azure |
| **IaC Framework** | Terraform |
| **Security & IAM** | Azure Key Vault, Managed Identities, RBAC, NSGs |
| **Compute & Network** | Azure VMs, VNet, Subnets, Bastion Host |
| **Monitoring** | Azure Monitor, Log Analytics |
| **Development Tools** | Azure CLI, PowerShell, GitHub, VS Code |

---

## 🧠 Problem → Solution

| Aspect | Description |
|---------|-------------|
| **Problem** | Cloud environments often lack a secure, repeatable deployment model. Credentials are mismanaged and network boundaries inconsistently enforced. |
| **Solution** | A **Terraform-driven Azure environment** that enforces least privilege, centralized secret management, and secure subnet isolation. |

**Input:**  
Terraform modules for network, compute, Key Vault, and RBAC configurations.

**Output:**  
A **hardened Azure lab** with centralized secrets, restricted network access, and automated cost controls.

---

## 🧩 Modular Terraform Design

| Module | Description |
|---------|-------------|
| **Network Module** | Creates VNet, subnets (DMZ + App), and NSGs with restrictive rules. |
| **Compute Module** | Provisions Bastion VM (public subnet) and Private VM (private subnet) with Managed Identities. |
| **Key Vault Module** | Stores SSH keys and secrets; manages access policies. |
| **Security Module** | Implements RBAC, Key Vault permissions, and least privilege. |

---

## 🔐 Security Implementation Highlights

| Security Layer | Control Implemented |
|----------------|---------------------|
| **Identity Security** | Managed Identities and RBAC for secret access |
| **Network Security** | Public/Private subnet isolation using NSGs |
| **Data Protection** | Key Vault encryption, soft delete, versioning |
| **Operational Security** | UFW, Fail2ban, Unattended Upgrades, Azure Monitor |
| **Secret Zero Principle** | No plaintext secrets in Terraform code |
| **Access Control** | Bastion host allows SSH only from admin IP |
| **Audit Logging** | Key Vault diagnostics for access tracking |

---

## 💰 Cost Optimization

- Auto-shutdown (7 PM UTC) for all VMs  
- **VM SKU:** Standard_B1s (Free-tier eligible)  
- **Storage:** Standard_LRS  
- **Public IP:** Standard SKU  
- **Monitoring:** Free tier (Azure Monitor, Log Analytics)  

💡 **Estimated Monthly Cost:** ~$15–20 (with auto-shutdown enabled)

---

## 📈 Security & Compliance Alignment

| Framework | Implementation |
|------------|----------------|
| **ISO/IEC 27001** | A.9 Access Control, A.10 Cryptographic Controls — via RBAC and Key Vault |
| **NIST CSF** | *Protect* and *Detect* functions through IAM, logging, and segmentation |
| **CIS Controls v8** | Controls 3 (Data Protection), 4 (Secure Configs), 6 (Access Management) |
| **Azure Well-Architected Framework** | Security, Reliability, and Cost Optimization pillars addressed |

---

## 🧰 Deployment Guide

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/asi-im-bir/TerraformSecureInfraLab.git
cd TerraformSecureInfraLab
2️⃣ Configure Variables
bash
Copy code
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your Azure configuration
3️⃣ Deploy the Infrastructure
bash
Copy code
terraform init
terraform plan
terraform apply
4️⃣ Validate Deployment
✅ SSH to Bastion VM from your admin IP only

✅ Confirm Private VM has no public IP

✅ Retrieve secrets from Key Vault via Managed Identity

📚 Lessons Learned
Modular Terraform improves scalability and maintainability

Managed Identities + Key Vault eliminate credential exposure

Defense-in-Depth through IAM + NSGs = layered protection

Negative access tests validated IAM and NSG boundaries

Balancing cost optimization with security controls is key

💼 Value to Employers
This project demonstrates the ability to:

✅ Architect secure Azure environments with Terraform
✅ Embed security and compliance controls in IaC
✅ Integrate Key Vault, RBAC, and NSGs effectively
✅ Apply DevSecOps practices for automated, auditable deployments
✅ Deliver ISO 27001 / NIST CSF-aligned infrastructure design

🧩 Future Roadmap
Enhancement	Description
CI/CD Integration	Automate Terraform via GitHub Actions or Azure DevOps
Policy-as-Code	Enforce Azure Policies for compliance and tagging
RBAC Authorization for Key Vault	Replace access policies with Azure RBAC
Private Endpoints	Isolate Key Vault and Storage within VNet
Azure Sentinel Integration	Real-time threat detection and logging
Multi-Region Design	Add redundancy and disaster recovery
