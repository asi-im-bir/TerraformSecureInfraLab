#!/bin/bash
set -e

# Wait for cloud-init to complete

# Wait for apt locks to be released
echo "Waiting for apt locks to be released..."
while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || \
      sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 || \
      sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 || \
      sudo fuser /var/cache/apt/archives/lock >/dev/null 2>&1; do
    echo "Waiting for other apt processes to finish..."
    sleep 5
done

# Update system
apt-get update

# Install prerequisites
apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

# Add Microsoft's GPG key and Azure CLI repository
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | tee /etc/apt/sources.list.d/azure-cli.list

# Update again with new repo
apt-get update

# Install essential security packages
apt-get install -y \
    ufw \
    fail2ban \
    unattended-upgrades \
    apt-listchanges \
    needrestart \
    azure-cli \
    jq

# Configure automatic security updates
echo 'Unattended-Upgrade::Automatic-Reboot "false";' >> /etc/apt/apt.conf.d/50unattended-upgrades
echo 'Unattended-Upgrade::Mail "root";' >> /etc/apt/apt.conf.d/50unattended-upgrades
systemctl enable unattended-upgrades

# Configure UFW firewall
ufw --force enable
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp  # SSH
ufw reload

# Configure fail2ban for SSH protection
cat > /etc/fail2ban/jail.local <<EOF
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
EOF

systemctl enable fail2ban
systemctl restart fail2ban

# Harden SSH configuration
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config
echo "MaxAuthTries 3" >> /etc/ssh/sshd_config
echo "ClientAliveInterval 300" >> /etc/ssh/sshd_config
echo "ClientAliveCountMax 2" >> /etc/ssh/sshd_config
systemctl restart sshd

# Configure system auditing
apt-get install -y auditd
systemctl enable auditd
systemctl start auditd

# Set up log rotation
cat > /etc/logrotate.d/azure-security <<EOF
/var/log/auth.log {
    weekly
    rotate 52
    compress
    delaycompress
    missingok
    notifempty
}
EOF

# Create script for Key Vault access
cat > /usr/local/bin/get-secret.sh <<'SCRIPT'
#!/bin/bash
SECRET_NAME=$1
KV_NAME=${key_vault_name}

# Login with managed identity
az login --identity --allow-no-subscriptions 2>/dev/null

# Retrieve secret
az keyvault secret show --vault-name $KV_NAME --name $SECRET_NAME --query value -o tsv
SCRIPT

chmod +x /usr/local/bin/get-secret.sh

# Create MOTD banner
cat > /etc/motd <<EOF
#############################################################
#                   AUTHORIZED ACCESS ONLY                 #
#  All actions are logged and monitored. Disconnect now    #
#  if you are not an authorized user.                      #
#############################################################
Environment: ${admin_username}
Managed by: Terraform
EOF

echo "Security hardening completed successfully"