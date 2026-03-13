# Quick Start Guide

**Installation Hub for OpenCode & AI Development Environment**

---

## 🚀 One-Line Installation

```bash
git clone https://github.com/YOUR_USERNAME/opencode-config-backup.git
cd opencode-config-backup
./setup-wizard.sh
```

---

## 📋 What You'll Get

✅ **Modern CLI Tools** - eza, bat, ripgrep, fd, zoxide, fzf, lazygit  
✅ **OpenCode Ecosystem** - OpenCode CLI, Oh My OpenCode, MCP servers  
✅ **AI Frameworks** - LangChain, CrewAI, LiteLLM, Ollama  
✅ **DevOps Tools** - Docker, Kubernetes, Terraform (optional)  
✅ **Android Tools** - ADB, scrcpy for remote access (optional)

---

## 📖 Documentation

- **[README.md](README.md)** - Complete overview and usage guide
- **[INSTALLATION_HUB.md](INSTALLATION_HUB.md)** - Detailed installation reference
- **[docs/TOOLS_CATALOG_2026.md
- **[docs/MCP_SERVERS_REFERENCE.md](docs/MCP_SERVERS_REFERENCE.md)** - MCP servers reference](docs/TOOLS_CATALOG_2026.md)** - Modern developer tools
- **[docs/LLM_INSTALL_GUIDE.md](docs/LLM_INSTALL_GUIDE.md)** - LLM setup and configuration
- **[docs/ANDROID_REMOTE_ACCESS.md](docs/ANDROID_REMOTE_ACCESS.md)** - Android debugging

---

## ⚡ Quick Commands

```bash
# Interactive setup
./setup-wizard.sh

# Install everything
./install-all.sh

# Install specific components
./install/install-cli.sh      # Modern CLI tools
./install/install-ai.sh        # AI frameworks
./install/install-opencode.sh  # OpenCode ecosystem

# Verify installation
./scripts/verify-install.sh
```

---

## 🔧 Configuration

After installation, configure API keys:

```bash
nano ~/.config/opencode/.env
```

Then restart your shell:

```bash
source ~/.bashrc
```

---

## 📦 What's Included

### Installation Scripts
- `setup-wizard.sh` - Interactive configuration
- `install-all.sh` - Master orchestrator
- `install/install-*.sh` - Component installers
- `scripts/verify-install.sh` - Verification

### Configuration
- `config/.env.template` - Environment variables
- `opencode.json` - OpenCode configuration
- `oh-my-opencode.json` - OMO settings

### Skills & Agents
- `superpowers/` - Superpowers skill system
- `agents/` - Custom agent configs

---

**Last Updated:** 2026-03-13
