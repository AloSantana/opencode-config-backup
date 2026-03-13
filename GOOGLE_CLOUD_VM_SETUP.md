# Google Cloud Ubuntu VM Setup Guide

**Complete setup guide for Google Cloud Ubuntu VM with OpenCode, OpenClaw, and remote access tools**

**Last Updated:** 2026-03-13

---

## Table of Contents

1. [Google Cloud VM Setup](#google-cloud-vm-setup)
2. [Essential Ubuntu Server Tools](#essential-ubuntu-server-tools)
3. [Remote Access Tools](#remote-access-tools)
4. [File Transfer & Sync](#file-transfer--sync)
5. [Tunneling & Port Forwarding](#tunneling--port-forwarding)
6. [OpenClaw Installation](#openclaw-installation)
7. [OpenCode Installation](#opencode-installation)
8. [Cloud Storage Integration](#cloud-storage-integration)
9. [System Monitoring](#system-monitoring)
10. [Security Hardening](#security-hardening)

---

## Google Cloud VM Setup

### 1. Create Ubuntu VM

```bash
# Install Google Cloud SDK locally
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Initialize gcloud
gcloud init

# Create Ubuntu 24.04 LTS VM
gcloud compute instances create ai-dev-vm \
  --zone=us-central1-a \
  --machine-type=e2-standard-4 \
  --image-family=ubuntu-2404-lts \
  --image-project=ubuntu-os-cloud \
  --boot-disk-size=100GB \
  --boot-disk-type=pd-balanced \
  --tags=http-server,https-server

# SSH into VM
gcloud compute ssh ai-dev-vm --zone=us-central1-a
```

### 2. Initial VM Configuration

```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Set timezone
sudo timedatectl set-timezone UTC

# Install essential build tools
sudo apt install -y build-essential curl wget git vim tmux htop
```

### 3. Install Google Cloud Tools

```bash
# Google Cloud SDK (if not pre-installed)
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt install -y google-cloud-sdk

# Verify installation
gcloud version
gsutil version
```

---

## Essential Ubuntu Server Tools

### Package Managers

```bash
# Install uv (Python package manager)
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Install Bun (JavaScript runtime)
curl -fsSL https://bun.sh/install | bash
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Install Rust/Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
```

### Modern CLI Tools

```bash
# Install via cargo
cargo install eza fd-find bat ripgrep zoxide procs git-delta starship

# Install via apt
sudo apt install -y jq tmux btop

# Setup aliases
cat >> ~/.bashrc << 'EOF'

# Modern CLI aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias ps='procs'

# Initialize tools
eval "$(zoxide init bash)"
eval "$(starship init bash)"
EOF

source ~/.bashrc
```

---

## Remote Access Tools

### 1. SSH Enhancements

#### Mosh (Mobile Shell)
**Best for high-latency or intermittent connections**

```bash
# Install
sudo apt install -y mosh

# Usage (from local machine)
mosh user@vm-ip
```

#### Eternal Terminal (ET)
**Better scrollback and auto-reconnect**

```bash
# Install
sudo apt install -y et

# Usage (from local machine)
et user@vm-ip:2022
```

### 2. SSH Security Hardening

```bash
# Generate Ed25519 key (more secure than RSA)
ssh-keygen -t ed25519 -a 100 -f ~/.ssh/gcp_vm_key

# Copy to VM
ssh-copy-id -i ~/.ssh/gcp_vm_key.pub user@vm-ip

# Harden SSH config
sudo tee -a /etc/ssh/sshd_config << 'EOF'

# Security hardening
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
MaxAuthTries 3
MaxSessions 5

# Modern key exchange
KexAlgorithms sntrup761x25519-sha512@openssh.com,curve25519-sha256,curve25519-sha256@libssh.org
EOF

sudo systemctl restart sshd
```

### 3. Terminal Multiplexers

#### Tmux (Industry Standard)

```bash
# Install
sudo apt install -y tmux

# Create config
cat > ~/.tmux.conf << 'EOF'
# Enable mouse
set -g mouse on

# Better prefix
set -g prefix C-a
unbind C-b

# Start windows at 1
set -g base-index 1

# Better colors
set -g default-terminal "screen-256color"
EOF
```

#### Zellij (Modern Alternative)

```bash
# Install
cargo install zellij

# Usage
zellij
```

---

## File Transfer & Sync

### 1. Rclone (Cloud Storage Swiss Army Knife)

**Supports 70+ cloud providers - fastest for cloud-to-cloud transfers**

```bash
# Install
sudo -v && curl https://rclone.org/install.sh | sudo bash

# Configure (interactive)
rclone config

# Sync local to cloud
rclone sync /local/path remote:bucket --progress --transfers 8

# Mount cloud storage
rclone mount remote:path /mnt/cloud --vfs-cache-mode full --daemon

# Copy from Google Cloud Storage
rclone copy gs://bucket-name /local/path --progress
```

### 2. Croc (Easy P2P Transfer)

**Easiest way to transfer files between any two computers**

```bash
# Install
curl https://getcroc.schollz.com | bash

# Send file
croc send myfile.zip
# Generates code like: 1234-code-phrase

# Receive (on another machine)
croc 1234-code-phrase
```

### 3. Syncthing (Continuous Sync)

**P2P continuous file synchronization**

```bash
# Install
sudo apt install -y syncthing

# Start service
systemctl --user enable syncthing
systemctl --user start syncthing

# Access web UI
# http://localhost:8384
```

### 4. Rsync (Traditional)

```bash
# Sync from local to VM
rsync -avz --progress /local/path/ user@vm-ip:/remote/path/

# Sync from VM to local
rsync -avz --progress user@vm-ip:/remote/path/ /local/path/

# With compression and bandwidth limit
rsync -avz --progress --bwlimit=10000 /local/path/ user@vm-ip:/remote/path/
```

---

## Tunneling & Port Forwarding

### 1. Cloudflare Tunnel (Recommended)

**Zero-trust, outbound-only connections - no open ports needed**

```bash
# Install cloudflared
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
sudo install cloudflared /usr/local/bin/
rm cloudflared

# Quick tunnel (temporary)
cloudflared tunnel --url http://localhost:8080

# Permanent tunnel setup
cloudflared tunnel login
cloudflared tunnel create my-tunnel
cloudflared tunnel route dns my-tunnel tunnel.yourdomain.com
cloudflared tunnel run my-tunnel
```

### 2. Rathole (High-Performance)

**Rust-based, faster than ngrok for high-throughput**

```bash
# Install
cargo install rathole

# Server config (server.toml)
cat > server.toml << 'EOF'
[server]
bind_addr = "0.0.0.0:2333"

[server.services.ssh]
token = "your_secure_token"
bind_addr = "0.0.0.0:2222"
EOF

# Client config (client.toml)
cat > client.toml << 'EOF'
[client]
remote_addr = "server-ip:2333"

[client.services.ssh]
token = "your_secure_token"
local_addr = "127.0.0.1:22"
EOF

# Run server
rathole server.toml

# Run client
rathole client.toml
```

### 3. Bore (Zero-Config)

**Fastest setup for temporary sharing**

```bash
# Install
cargo install bore-cli

# Expose local port
bore local 8080 --to bore.pub
```

### 4. Ngrok Alternatives (2026)

**Modern alternatives to ngrok:**

- **Wormhole** - Open-source, no signup, free custom subdomains
- **LocalXpose** - Unlimited bandwidth on free tier
- **Pinggy** - No signup required, UDP support
- **Zrok** - Self-hostable, OpenZiti-based

```bash
# Example: Wormhole
curl -sSL https://wormhole.app/install.sh | bash
wormhole http 3000
```

---

## OpenClaw Installation

**OpenClaw is a self-hosted AI gateway and autonomous agent engine**

### System Requirements

- Node.js 22+
- Ubuntu 20.04+ / macOS / Windows (WSL2)
- 2GB+ RAM
- API keys (OpenAI, Anthropic, or OpenRouter)

### Installation

```bash
# Install Node.js 22 (if not installed)
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Install OpenClaw globally
npm install -g openclaw@latest

# Or via installer script
curl -fsSL --proto '=https' --tlsv1.2 https://openclaw.ai/install.sh | bash

# Run onboarding wizard
openclaw onboard --install-daemon

# Check status
openclaw status
```

### Configuration

```bash
# Workspace location
cd ~/.openclaw/workspace

# Configure API keys
openclaw config set OPENAI_API_KEY="your-key"
openclaw config set ANTHROPIC_API_KEY="your-key"

# Start gateway
openclaw gateway start

# Access control UI
open http://localhost:3000
```

### Features

- **Multi-channel support**: WhatsApp, Telegram, Discord, Slack
- **Autonomous agents**: 24/7 AI agents with cron jobs
- **Skills system**: AgentSkills-compatible
- **Local-first**: Privacy-focused, self-hosted
- **Gateway**: Unified API for multiple LLM providers

### Integration with Telegram

```bash
# Get Telegram bot token from @BotFather
# Configure in OpenClaw
openclaw channel add telegram --token="your-bot-token"

# Start bot
openclaw channel start telegram
```

---

## OpenCode Installation

**OpenCode CLI for AI-powered coding**

```bash
# Install OpenCode
npm install -g @opencode-ai/cli

# Or via Bun (faster)
bun install -g @opencode-ai/cli

# Install Oh My OpenCode
npm install -g oh-my-opencode

# Verify installation
opencode --version
opencode models

# Configure
opencode config
```

---

## Cloud Storage Integration

### 1. Google Cloud Storage (gcsfuse)

**Mount GCS buckets as local filesystem**

```bash
# Install gcsfuse
export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s`
echo "deb https://packages.cloud.google.com/apt $GCSFUSE_REPO main" | sudo tee /etc/apt/sources.list.d/gcsfuse.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt update && sudo apt install -y gcsfuse

# Mount bucket
mkdir -p ~/gcs-mount
gcsfuse my-bucket ~/gcs-mount

# Auto-mount on boot
echo "gcsfuse my-bucket /home/$USER/gcs-mount" | sudo tee -a /etc/fstab
```

### 2. Rclone Mount

```bash
# Mount any cloud storage
rclone mount remote:path /mnt/cloud \
  --vfs-cache-mode full \
  --vfs-cache-max-size 10G \
  --daemon

# Unmount
fusermount -u /mnt/cloud
```

---

## System Monitoring

### 1. btop (Modern htop)

```bash
# Install
sudo apt install -y btop

# Run
btop
```

### 2. Google Cloud Monitoring Agent

```bash
# Install monitoring agent
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Verify
sudo systemctl status google-cloud-ops-agent
```

### 3. Disk Usage Monitoring

```bash
# Install ncdu
sudo apt install -y ncdu

# Analyze disk usage
ncdu /

# Or use modern alternative
cargo install dust
dust /
```

---

## Security Hardening

### 1. Firewall Configuration

```bash
# Install UFW
sudo apt install -y ufw

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH
sudo ufw allow 22/tcp

# Allow specific ports
sudo ufw allow 8080/tcp

# Enable firewall
sudo ufw enable

# Check status
sudo ufw status verbose
```

### 2. Fail2Ban (Brute Force Protection)

```bash
# Install
sudo apt install -y fail2ban

# Configure
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Edit config
sudo nano /etc/fail2ban/jail.local
# Set: bantime = 1h, maxretry = 3

# Restart
sudo systemctl restart fail2ban

# Check status
sudo fail2ban-client status sshd
```

### 3. Automatic Security Updates

```bash
# Install unattended-upgrades
sudo apt install -y unattended-upgrades

# Enable
sudo dpkg-reconfigure -plow unattended-upgrades

# Configure
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

---

## Complete Setup Script

Save as `gcp-vm-setup.sh`:

```bash
#!/bin/bash
set -e

echo "🚀 Starting Google Cloud Ubuntu VM Setup..."

# Update system
echo "📦 Updating system..."
sudo apt update && sudo apt upgrade -y

# Install essentials
echo "🛠️  Installing essential tools..."
sudo apt install -y build-essential curl wget git vim tmux htop jq btop ufw fail2ban

# Install package managers
echo "📦 Installing package managers..."
curl -LsSf https://astral.sh/uv/install.sh | sh
curl -fsSL https://bun.sh/install | bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source environments
export PATH="$HOME/.local/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
source "$HOME/.cargo/env"

# Install modern CLI tools
echo "🔧 Installing modern CLI tools..."
cargo install eza fd-find bat ripgrep zoxide procs git-delta starship

# Install Node.js 22
echo "📦 Installing Node.js 22..."
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs

# Install OpenCode
echo "🤖 Installing OpenCode..."
npm install -g @opencode-ai/cli oh-my-opencode

# Install OpenClaw
echo "🦞 Installing OpenClaw..."
npm install -g openclaw@latest

# Install Rclone
echo "☁️  Installing Rclone..."
sudo -v && curl https://rclone.org/install.sh | sudo bash

# Install Cloudflared
echo "🌐 Installing Cloudflare Tunnel..."
curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o cloudflared
sudo install cloudflared /usr/local/bin/
rm cloudflared

# Setup firewall
echo "🔒 Configuring firewall..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw --force enable

# Setup shell aliases
echo "🎨 Setting up shell configuration..."
cat >> ~/.bashrc << 'EOF'

# Modern CLI aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias ps='procs'

# Initialize tools
eval "$(zoxide init bash)"
eval "$(starship init bash)"

# Add paths
export PATH="$HOME/.local/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
EOF

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc"
echo "2. Configure OpenClaw: openclaw onboard"
echo "3. Configure OpenCode: opencode config"
echo "4. Setup SSH keys for secure access"
echo ""
echo "🎉 Your Google Cloud VM is ready for AI development!"
```

Make executable and run:
```bash
chmod +x gcp-vm-setup.sh
./gcp-vm-setup.sh
```

---

## Quick Reference

### Essential Commands

```bash
# System monitoring
btop                    # System monitor
ncdu /                  # Disk usage
journalctl -f           # System logs

# File transfer
croc send file.zip      # Send file
rclone sync local remote --progress  # Sync to cloud

# Tunneling
cloudflared tunnel --url http://localhost:8080  # Quick tunnel
bore local 3000         # Expose port

# OpenClaw
openclaw status         # Check status
openclaw logs           # View logs
openclaw gateway start  # Start gateway

# OpenCode
opencode                # Start OpenCode
opencode models         # List models
```

### Useful Aliases

```bash
# Add to ~/.bashrc
alias vm-status='btop'
alias vm-disk='ncdu /'
alias vm-logs='journalctl -f'
alias tunnel='cloudflared tunnel --url'
```

---

## Troubleshooting

### SSH Connection Issues

```bash
# Check SSH service
sudo systemctl status sshd

# Check firewall
sudo ufw status

# Test connection
ssh -vvv user@vm-ip
```

### OpenClaw Issues

```bash
# Check logs
openclaw logs

# Restart gateway
openclaw gateway restart

# Reset configuration
openclaw config reset
```

### Disk Space Issues

```bash
# Check disk usage
df -h

# Find large files
ncdu /

# Clean package cache
sudo apt clean
sudo apt autoremove
```

---

## Additional Resources

- [Google Cloud Documentation](https://cloud.google.com/docs)
- [OpenClaw Documentation](https://openclawlab.com/en/docs/)
- [OpenCode Documentation](https://opencode.ai/docs)
- [Rclone Documentation](https://rclone.org/docs/)
- [Cloudflare Tunnel Documentation](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/)

---

**Generated:** 2026-03-13  
**For:** Google Cloud Ubuntu VM Setup  
**License:** MIT
