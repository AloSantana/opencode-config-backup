# OpenCode Configuration & Installation Hub

**Last Updated:** 2026-03-13

Complete OpenCode configuration backup and automated installation system for AI-powered development environments.

---

## Quick Start

### One-Line Installation

```bash
git clone https://github.com/YOUR_USERNAME/opencode-config-backup.git
cd opencode-config-backup
./setup-wizard.sh
```

The setup wizard will guide you through:
1. Component selection (CLI tools, DevOps, AI frameworks, etc.)
2. API key configuration
3. Model preferences
4. Shell customization

Then run:
```bash
./install-all.sh
```

---

## What's Included

### Installation Scripts

- **setup-wizard.sh** - Interactive configuration wizard
- **install-all.sh** - Master orchestrator for all installations
- **install/install-base.sh** - Base system packages
- **install/install-cli.sh** - Modern CLI tools (eza, bat, ripgrep, etc.)
- **install/install-devops.sh** - Docker, Kubernetes, Terraform, Ansible
- **install/install-ai.sh** - LangChain, CrewAI, LiteLLM, Ollama
- **install/install-opencode.sh** - OpenCode ecosystem & MCP servers
- **install/install-android.sh** - Android remote access tools
- **scripts/verify-install.sh** - Post-installation verification

### Configuration Files

- **opencode.json** - Main OpenCode configuration
- **oh-my-opencode.json** - Oh My OpenCode settings
- **config/.env.template** - Environment variables template
- **config/manifest.json.template** - Installation manifest

### Documentation

- **INSTALLATION_HUB.md** - Complete installation guide
- **docs/TOOLS_CATALOG_2026.md
- **[docs/MCP_SERVERS_REFERENCE.md](docs/MCP_SERVERS_REFERENCE.md)** - Complete MCP servers catalog** - Modern developer tools catalog
- **docs/LLM_INSTALL_GUIDE.md** - LLM setup and configuration
- **docs/ANDROID_REMOTE_ACCESS.md** - Android debugging guide

### Skills & Agents

- **superpowers/** - Complete superpowers skill system
- **agents/** - Custom agent configurations
- **skills/** - Additional skill definitions

---

## Installation Options

### Interactive Setup (Recommended)

```bash
./setup-wizard.sh
```

Prompts for:
- Component selection
- API keys
- Model preferences
- Shell configuration

### Manual Component Installation

```bash
# Base system only
./install/install-base.sh

# Modern CLI tools
./install/install-cli.sh

# AI frameworks
./install/install-ai.sh

# OpenCode ecosystem
./install/install-opencode.sh

# DevOps tools (optional)
./install/install-devops.sh

# Android tools (optional)
./install/install-android.sh
```

### Verification

```bash
./scripts/verify-install.sh
```

---

## Directory Structure

```
.
├── install/                    # Installation scripts
│   ├── install-base.sh
│   ├── install-cli.sh
│   ├── install-devops.sh
│   ├── install-ai.sh
│   ├── install-opencode.sh
│   └── install-android.sh
├── scripts/                    # Utility scripts
│   └── verify-install.sh
├── config/                     # Configuration templates
│   ├── .env.template
│   └── manifest.json.template
├── docs/                       # Documentation
│   ├── TOOLS_CATALOG_2026.md
│   ├── LLM_INSTALL_GUIDE.md
│   └── ANDROID_REMOTE_ACCESS.md
├── agents/                     # Agent configurations
├── skills/                     # Skill definitions
├── superpowers/               # Superpowers skill system
├── setup-wizard.sh            # Interactive setup
├── install-all.sh             # Master installer
├── opencode.json              # OpenCode config
├── oh-my-opencode.json        # OMO config
├── INSTALLATION_HUB.md        # Complete guide
└── README.md                  # This file
```

---

## What Gets Installed

### Base System
- Git, curl, wget, build-essential
- Package managers: npm, bun, cargo, uv
- System utilities: jq, yq

### Modern CLI Tools
- **File navigation:** eza, fd, zoxide
- **File viewing:** bat, ripgrep, fzf
- **Git tools:** lazygit, delta, gh
- **Process monitoring:** btop, procs
- **Shell:** starship prompt

### OpenCode Ecosystem
- OpenCode CLI
- Oh My OpenCode
- Superpowers skills
- MCP servers (filesystem, git, memory, etc.)

### AI Frameworks
- LangChain (Python & JS)
- CrewAI
- LiteLLM
- Ollama (local LLM runtime)
- Vector databases (Qdrant, ChromaDB, FAISS)

### DevOps Tools (Optional)
- Docker & Docker Compose
- Kubernetes (kubectl, k9s, helm)
- Terraform, Ansible, Pulumi
- Cloud CLIs (AWS, GCP, Azure)

### Android Tools (Optional)
- ADB (Android Debug Bridge)
- scrcpy (screen mirroring)
- Wireless debugging scripts

---

## Configuration

### Environment Variables

After installation, configure API keys:

```bash
nano ~/.config/opencode/.env
```

Required for full functionality:
```bash
# AI Services
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-..."
export GEMINI_API_KEY="..."

# Search APIs
export TAVILY_API_KEY="tvly-..."
export BRAVE_API_KEY="..."

# GitHub
export GITHUB_TOKEN="ghp_..."
```

### OpenCode Configuration

Edit OpenCode settings:
```bash
nano ~/.config/opencode/opencode.json
```

### Shell Configuration

Aliases and tools are automatically configured in `~/.bashrc` or `~/.zshrc`.

Reload shell:
```bash
source ~/.bashrc
```

---

## Usage Examples

### OpenCode

```bash
# Check version
opencode --version

# List available models
opencode models

# Start coding
opencode

# Use specific model
opencode --model claude-sonnet-4
```

### Modern CLI Tools

```bash
# File navigation
ls          # eza with icons
ll          # detailed list
tree        # tree view

# File search
fd pattern
rg "search term"

# Git
lg          # lazygit UI
gh pr create

# Process monitoring
btop
procs
```

### AI Development

```bash
# Local LLM
ollama run llama2
ollama pull mistral

# Python AI frameworks
python -c "import langchain; print(langchain.__version__)"
```

---

## Backup & Restore

### Backup Current Config

```bash
cp -r ~/.config/opencode ~/opencode-backup-$(date +%Y%m%d)
```

### Restore from This Repo

```bash
cp -r ./* ~/.config/opencode/
source ~/.bashrc
```

---

## Troubleshooting

### Installation Issues

```bash
# Check installation log
cat ~/opencode-install-*.log

# Verify installation
./scripts/verify-install.sh

# Re-run specific component
./install/install-cli.sh
```

### OpenCode Issues

```bash
# Check OpenCode status
opencode --version

# Verify configuration
cat ~/.config/opencode/opencode.json

# Check environment variables
env | grep -E "ANTHROPIC|OPENAI|GEMINI"
```

### Permission Issues

```bash
# Fix script permissions
chmod +x setup-wizard.sh install-all.sh
chmod +x install/*.sh scripts/*.sh

# Add user to docker group (if using Docker)
sudo usermod -aG docker $USER
# Logout and login again
```

---

## Documentation

- **[INSTALLATION_HUB.md](INSTALLATION_HUB.md)** - Complete installation guide with all tools and MCP servers
- **[docs/TOOLS_CATALOG_2026.md
- **[docs/MCP_SERVERS_REFERENCE.md](docs/MCP_SERVERS_REFERENCE.md)** - Complete MCP servers catalog](docs/TOOLS_CATALOG_2026.md)** - Comprehensive catalog of modern developer tools
- **[docs/LLM_INSTALL_GUIDE.md](docs/LLM_INSTALL_GUIDE.md)** - LLM installation, configuration, and best practices
- **[docs/ANDROID_REMOTE_ACCESS.md](docs/ANDROID_REMOTE_ACCESS.md)** - Android debugging and screen mirroring guide

---

## Contributing

This is a personal configuration backup, but feel free to fork and adapt for your needs.

---

## License

MIT

---

## Credits

- **OpenCode** - https://opencode.ai
- **Oh My OpenCode** - https://github.com/code-yeongyu/oh-my-openagent
- **Superpowers** - https://github.com/superpowers-ai/superpowers
- **Modern CLI Tools** - Various open source projects

---

**Last Updated:** 2026-03-13  
**Maintained by:** OpenCode Community
