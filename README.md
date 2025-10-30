## 🎯 Summary for Hiring Managers

The **Terraform Secure Infrastructure Lab** showcases my ability to **architect, automate, and secure cloud environments** using **Terraform Infrastructure as Code (IaC)** and **Azure-native security controls**.  
It demonstrates how to implement **defense-in-depth**, **least privilege**, and **secret zero** principles through fully automated, modular Terraform design.

---

### 🧩 Key Security Implementations

| Security Domain | Implementation | Impact |
|------------------|----------------|--------|
| **Identity & Access Management (IAM)** | Enforced least privilege with **Azure RBAC** and **Managed Identities** — no static credentials in code. | Eliminates secret sprawl and lateral movement risk. |
| **Secret Management** | Centralized all credentials in **Azure Key Vault** with **soft delete**, **audit logging**, and **RBAC policies**. | Ensures full secret lifecycle control and ISO 27001 A.10 compliance. |
| **Network Security** | Segmented network into **Public (DMZ)** and **Private (App)** subnets with restrictive **NSG rules**. | Reduces attack surface and isolates workloads from the internet. |
| **Operational Security** | Applied **UFW**, **Fail2ban**, and **unattended-upgrades** on all VMs. | Provides host-level hardening and automated patching. |
| **Monitoring & Auditing** | Integrated **Azure Monitor** and **Log Analytics** for telemetry and access visibility. | Enables continuous compliance and real-time incident detection. |

---

### 🔐 Design Principles Applied
- **Defense-in-Depth:** Layered identity, network, and data protection.  
- **Secret Zero:** No plaintext secrets — all accessed via Managed Identities.  
- **Least Privilege:** Every component runs with minimal necessary permissions.  
- **Immutable Infrastructure:** Fully version-controlled, reproducible Terraform builds.  

---

### 🛡️ Compliance Alignment

| Framework | Implementation |
|------------|----------------|
| **ISO/IEC 27001** | A.9 Access Control, A.10 Cryptographic Controls via Key Vault and RBAC. |
| **NIST CSF** | *Protect* and *Detect* functions implemented through IAM, logging, and segmentation. |
| **CIS Controls v8** | Controls 3 (Data Protection), 4 (Secure Configurations), 6 (Access Management). |

---

### 💼 Business Value

By embedding **security controls directly into Terraform modules**, this lab delivers:

- ✅ **Continuous compliance** with minimal manual audit effort  
- ✅ **Secure-by-default deployments** for Dev/Test workloads  
- ✅ **Integrated GRC and DevSecOps** alignment  
- ✅ **Reduced operational cost** without weakening security  

> 🔑 *This project demonstrates my ability to bridge DevSecOps automation with GRC governance — building infrastructure that is secure, compliant, and production-ready from day one.*



# 🌩️ Terraform Secure Infrastructure Lab in Detail
### Azure Key Vault Security | Defense-in-Depth Cloud Architecture

> **A Terraform-based Azure infrastructure lab** demonstrating secure-by-design principles — built with **defense-in-depth**, **least privilege**, and **separation of duties**.  
> Implements **Azure Key Vault**, **Managed Identities**, and **modular IaC** patterns aligned with the **Azure Well-Architected Framework** (Security, Reliability, and Cost Optimization pillars).

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

## 🏗️ Technical Architecture

<p align="center">
  <img src="https://raw.githubusercontent.com/asi-im-bir/TerraformSecureInfraLab/main/terraform.png" alt="Terraform Secure Infrastructure Architecture" width="750"/>
</p>

The **Terraform Secure Infrastructure Lab** builds a **defense-in-depth Azure environment** that separates public and private workloads, manages secrets securely, and enforces least-privilege access.

---

### 🌐 Overview

All resources are deployed inside an **Azure Virtual Network (VNet)** divided into two subnets:

- **Public Subnet (DMZ):** Hosts the **Bastion VM**, the only resource with a public IP.  
  SSH access is restricted to a specific admin IP.

- **Private Subnet (App):** Hosts the **Private VM**, which has **no public IP** and connects only through the Bastion VM.

- **Azure Key Vault:** Stores all secrets (e.g., SSH keys, credentials) and is accessed securely via **Managed Identities**, eliminating plaintext secrets.

- **Azure Active Directory (AAD):** Provides authentication and **Role-Based Access Control (RBAC)** for users and services.

- **Azure Monitor & Log Analytics:** Collect logs and metrics from all components for visibility, alerting, and compliance.

---

### 🔐 Security Layers

| Layer | Implementation |
|--------|----------------|
| **Network Isolation** | Public and private subnets protected with NSGs and minimal open ports. |
| **Identity Security** | Managed Identities and RBAC ensure least-privilege access. |
| **Secret Management** | Centralized secrets in Key Vault with soft delete and access logging. |
| **Operational Monitoring** | Azure Monitor tracks performance, security, and access events. |

---

### ⚙️ Flow Summary

1. Admin connects to **Bastion VM** from an approved IP via SSH.  
2. **Bastion VM** connects to **Private VM** over the internal network.  
3. **Private VM** retrieves secrets from **Azure Key Vault** using its Managed Identity.  
4. **Azure AD** authenticates all access requests and enforces RBAC.  

This architecture ensures a **secure, auditable, and cost-optimized Azure environment**, following best practices from the **Azure Well-Architected Framework**.

---

### 🔒 Security Flow Summary

| Component | Role | Key Security Controls |
|------------|------|------------------------|
| **Bastion VM** | Secure entry point | Public IP restricted to admin source IP; SSH only. |
| **Private VM** | Application workload | No public IP; accesses Key Vault via Managed Identity. |
| **Azure Key Vault** | Secrets management | Centralized credentials storage; access via RBAC. |
| **Managed Identity** | Credential access | Eliminates plaintext secrets; token-based auth. |
| **NSGs** | Network defense | Explicit allow/deny inbound and outbound rules. |
| **Azure Monitor** | Logging & telemetry | Collects logs and metrics for Bastion and Private VMs. |

---

## 📈 Security & Compliance Alignment

| Framework | Implementation |
|------------|----------------|
| **ISO/IEC 27001** | A.9 Access Control & A.10 Cryptographic Controls implemented via RBAC and Key Vault. |
| **NIST CSF** | *Protect* and *Detect* functions achieved through IAM, logging, and segmentation. |
| **CIS Controls v8** | Controls 3 (Data Protection), 4 (Secure Configurations), 6 (Access Management). |
| **Azure Well-Architected Framework** | Security, Reliability, and Cost Optimization pillars addressed. |

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
Modular Terraform design improves scalability and maintainability.

Managed Identities + Key Vault eliminate credential exposure.

Defense-in-Depth through IAM and NSGs provides layered protection.

Negative access tests validated IAM and NSG boundaries.

Balancing cost optimization with strong security controls is essential.

💼 Value to Employers
This project demonstrates the ability to:

✅ Architect secure Azure environments with Terraform
✅ Embed security and compliance controls in IaC
✅ Integrate Key Vault, RBAC, and NSGs effectively
✅ Apply DevSecOps practices for automated, auditable deployments
✅ Deliver ISO 27001 / NIST CSF-aligned infrastructure design

🧩 Future Roadmap
Enhancement	Description
CI/CD Integration	Automate Terraform via GitHub Actions or Azure DevOps.
Policy-as-Code	Enforce Azure Policies for compliance and tagging.
RBAC Authorization for Key Vault	Replace access policies with Azure RBAC.
Private Endpoints	Isolate Key Vault and Storage within the VNet.
Azure Sentinel Integration	Enable real-time detection and centralized logging.
Multi-Region Design	Add redundancy and disaster recovery for resilience.


