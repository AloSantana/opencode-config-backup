# OpenCode & AI Development Environment - Complete Installation Hub

**Last Updated:** 2026-03-13

A comprehensive guide for setting up a complete AI-powered development environment with OpenCode, MCP servers, modern CLI tools, and agent frameworks.

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Core Installation](#core-installation)
3. [OpenCode Ecosystem](#opencode-ecosystem)
4. [MCP Servers](#mcp-servers)
5. [Modern CLI Tools](#modern-cli-tools)
6. [AI Agent Frameworks](#ai-agent-frameworks)
7. [IDE Extensions](#ide-extensions)
8. [Automated Installation](#automated-installation)

---

## Quick Start

### Prerequisites

```bash
# Install package managers
curl -fsSL https://bun.sh/install | bash  # Bun (fast npm alternative)
curl -LsSf https://astral.sh/uv/install.sh | sh  # uv (fast Python package manager)

# Install Node.js (if not using Bun)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Rust (for modern CLI tools)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### One-Line Setup

```bash
# Download and run the automated installer
curl -fsSL https://raw.githubusercontent.com/AloSantana/opencode-config-backup/main/install.sh | bash
```

---

## Core Installation

### 1. OpenCode CLI

**Official Installation:**
```bash
# Via npm
npm install -g @opencode-ai/cli

# Via Homebrew (macOS/Linux)
brew install opencode-ai/tap/opencode

# Via Bun (faster)
bun install -g @opencode-ai/cli
```

**Verify Installation:**
```bash
opencode --version
opencode models  # List available models
```

### 2. Essential Package Managers

**uv (Python)** - 10-100x faster than pip
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

**Bun (JavaScript)** - Fast npm alternative
```bash
curl -fsSL https://bun.sh/install | bash
```

**Cargo (Rust)** - For modern CLI tools
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

---

## OpenCode Ecosystem

### Official Plugins & Extensions

#### 1. Oh My OpenCode (OMO)
**Most popular OpenCode enhancement - parallel agents, multi-model orchestration**

```bash
# Installation
npm install -g oh-my-opencode

# Or add to opencode.json
opencode plugin add oh-my-opencode
```

**Features:**
- Parallel background agents
- Multi-model support (Claude/Gemini/GPT-4)
- LSP/AST search integration
- Advanced orchestration

**Repository:** https://github.com/code-yeongyu/oh-my-openagent

---

#### 2. OpenAgents Control (OAC)
**Pattern-based development with approval gates**

```bash
# Installation
curl -fsSL https://raw.githubusercontent.com/darrenhinde/OpenAgentsControl/main/install.sh | bash -s developer
```

**Features:**
- Teaches AI your coding patterns
- Approval gates before execution
- Team-ready (commit patterns to repo)
- MVI principle (80% token reduction)

**Repository:** https://github.com/darrenhinde/OpenAgentsControl

---



### Skills & Superpowers

#### Superpowers Skills
**Structured development workflows (TDD, debugging, code review)**

```bash
# Clone to OpenCode config
git clone https://github.com/superpowers-ai/superpowers ~/.config/opencode/superpowers
```

**Features:**
- Brainstorming skill
- Test-driven development
- Systematic debugging
- Code review workflows
- Git worktree management

---

#### Agent Skills Hub
**Global library of AI agent skills**

```bash
# Installation
git clone https://github.com/agent-skills-hub/agent-skills-hub ~/.config/opencode/skills
```

**Repository:** https://github.com/agent-skills-hub/agent-skills-hub

---

#### WordPress Agent Skills
**Expert WordPress development knowledge**

```bash
git clone https://github.com/WordPress/agent-skills ~/.config/opencode/skills/wordpress
```

**Repository:** https://github.com/WordPress/agent-skills

---

### Utilities & Tools

#### OpenCode.nvim
**Full Neovim integration**

```vim
" Add to init.vim or init.lua
Plug 'nickjvandyke/opencode.nvim'
```

**Repository:** https://github.com/nickjvandyke/opencode.nvim

---

#### OpenCode Worktree
**Automated Git worktree management**

```bash
npm install -g opencode-worktree
```

**Repository:** https://github.com/kdcokenny/opencode-worktree

---

## MCP Servers

### Official MCP Servers (Anthropic)

All MCP servers are configured in `~/.config/opencode/opencode.json` under the `mcp` section.

#### Development Tools

**Filesystem**
```json
{
  "filesystem": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-filesystem", "."],
    "enabled": true
  }
}
```

**Git**
```json
{
  "git": {
    "type": "local",
    "command": ["uvx", "mcp-server-git", "--repository", "."],
    "enabled": true
  }
}
```

**GitHub**
```json
{
  "github": {
    "type": "local",
    "command": ["npx", "-y", "@github/mcp-server"],
    "enabled": true,
    "environment": {
      "GITHUB_TOKEN": "${GITHUB_TOKEN}"
    }
  }
}
```

---

#### AI & Memory

**Memory (Knowledge Graph)**
```json
{
  "memory": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-memory"],
    "enabled": true
  }
}
```

**Sequential Thinking**
```json
{
  "sequential-thinking": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-sequential-thinking"],
    "enabled": true
  }
}
```

**Qdrant (Vector Database)**
```json
{
  "qdrant": {
    "type": "local",
    "command": ["uvx", "mcp-server-qdrant"],
    "enabled": true,
    "environment": {
      "QDRANT_URL": "${QDRANT_URL}",
      "QDRANT_API_KEY": "${QDRANT_API_KEY}",
      "COLLECTION_NAME": "agent-memory",
      "EMBEDDING_PROVIDER": "fastembed"
    }
  }
}
```

---

#### Web & Search

**Tavily (AI Search)**
```json
{
  "tavily": {
    "type": "local",
    "command": ["npx", "-y", "tavily-mcp"],
    "enabled": true,
    "environment": {
      "TAVILY_API_KEY": "${TAVILY_API_KEY}"
    }
  }
}
```

**Firecrawl (Web Scraping)**
```json
{
  "firecrawl": {
    "type": "local",
    "command": ["npx", "-y", "firecrawl-mcp"],
    "enabled": true,
    "environment": {
      "FIRECRAWL_API_KEY": "${FIRECRAWL_API_KEY}"
    }
  }
}
```

**Brave Search**
```json
{
  "brave-search": {
    "type": "local",
    "command": ["npx", "-y", "@brave/brave-search-mcp"],
    "enabled": true,
    "environment": {
      "BRAVE_API_KEY": "${BRAVE_API_KEY}"
    }
  }
}
```

---

#### Databases

**PostgreSQL**
```json
{
  "postgres": {
    "type": "local",
    "command": ["npx", "-y", "postgresql-mcp"],
    "enabled": true,
    "environment": {
      "POSTGRES_CONNECTION_STRING": "${POSTGRES_CONNECTION_STRING}"
    }
  }
}
```

**SQLite**
```json
{
  "sqlite": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-sqlite", "--db-path", "./data.db"],
    "enabled": true
  }
}
```

---

#### Browser Automation

**Playwright**
```json
{
  "playwright": {
    "type": "local",
    "command": ["npx", "-y", "@playwright/mcp", "--headless"],
    "enabled": true
  }
}
```

**Puppeteer**
```json
{
  "puppeteer": {
    "type": "local",
    "command": ["npx", "-y", "@modelcontextprotocol/server-puppeteer"],
    "enabled": true
  }
}
```

---

### Community MCP Servers

**Awesome MCP Server Lists:**
- https://github.com/punkpeye/awesome-mcp-servers (Primary - 7k+ stars)
- https://github.com/wong2/awesome-mcp-servers (700+ servers)
- https://github.com/appcypher/awesome-mcp-servers
- https://mcpservers.org/ (Directory)
- https://mcp.so/ (Directory)
- https://glama.ai/mcp/servers (Directory)

---

## Modern CLI Tools

### Rust-Based Alternatives to Classic Unix Tools

#### File & Directory Navigation

**eza** - Modern `ls` replacement
```bash
cargo install eza
# Or: brew install eza
# Or: apt install eza

# Aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias tree='eza --tree --icons'
```

**fd** - Modern `find` replacement
```bash
cargo install fd-find
# Or: brew install fd
# Or: apt install fd-find

# Usage
fd pattern  # Much faster than find
fd -e js    # Find all .js files
```

**zoxide** - Smarter `cd` command
```bash
cargo install zoxide
# Or: brew install zoxide

# Add to shell config
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc

# Usage
z path      # Jump to frequently used directory
zi          # Interactive directory selection
```

---

#### File Viewing & Search

**bat** - Modern `cat` with syntax highlighting
```bash
cargo install bat
# Or: brew install bat
# Or: apt install bat

alias cat='bat'
```

**ripgrep (rg)** - Faster `grep`
```bash
cargo install ripgrep
# Or: brew install ripgrep
# Or: apt install ripgrep

# Usage
rg pattern  # Search recursively
rg -t js pattern  # Search only .js files
```

**fzf** - Fuzzy finder
```bash
# Via git
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Or: brew install fzf
# Or: apt install fzf

# Usage
vim $(fzf)  # Fuzzy find and open file
```

---

#### Git Tools

**lazygit** - Terminal UI for git
```bash
# Via Homebrew
brew install lazygit

# Via Go
go install github.com/jesseduffield/lazygit@latest

# Via apt
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update
sudo apt install lazygit
```

**delta** - Better git diff
```bash
cargo install git-delta
# Or: brew install git-delta

# Configure git
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
```

**gh** - GitHub CLI
```bash
# Via Homebrew
brew install gh

# Via apt
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Authenticate
gh auth login
```

---

#### Process Monitoring

**btop** - Modern `htop`
```bash
# Via Homebrew
brew install btop

# Via apt
sudo apt install btop

# Via Snap
sudo snap install btop
```

**procs** - Modern `ps`
```bash
cargo install procs
# Or: brew install procs
```

---

#### JSON/YAML Tools

**jq** - JSON processor
```bash
sudo apt install jq
# Or: brew install jq

# Usage
cat file.json | jq '.key'
```

**yq** - YAML processor
```bash
# Via Homebrew
brew install yq

# Via Go
go install github.com/mikefarah/yq/v4@latest

# Via wget
wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O ~/.local/bin/yq
chmod +x ~/.local/bin/yq
```

**fx** - Interactive JSON viewer
```bash
npm install -g fx
# Or: brew install fx

# Usage
cat file.json | fx
```

---

#### Docker Tools

**lazydocker** - Terminal UI for Docker
```bash
# Via Homebrew
brew install lazydocker

# Via Go
go install github.com/jesseduffield/lazydocker@latest

# Via curl
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

**dive** - Docker image analyzer
```bash
# Via Homebrew
brew install dive

# Via wget
wget https://github.com/wagoodman/dive/releases/download/v0.12.0/dive_0.12.0_linux_amd64.deb
sudo apt install ./dive_0.12.0_linux_amd64.deb
```

---

#### API Testing

**httpie** - User-friendly HTTP client
```bash
# Via apt
sudo apt install httpie

# Via pip
pip install httpie

# Via Homebrew
brew install httpie

# Usage
http GET https://api.github.com/users/octocat
```

**xh** - Faster httpie (Rust)
```bash
cargo install xh
# Or: brew install xh

# Usage (same as httpie)
xh GET https://api.github.com/users/octocat
```

---

#### Terminal Multiplexers

**tmux** - Terminal multiplexer
```bash
sudo apt install tmux
# Or: brew install tmux

# Basic usage
tmux new -s session-name
tmux attach -t session-name
tmux ls
```

**zellij** - Modern tmux alternative (Rust)
```bash
cargo install zellij
# Or: brew install zellij

# Usage
zellij
```

---

#### Shell Enhancements

**starship** - Cross-shell prompt
```bash
cargo install starship
# Or: brew install starship
# Or: curl -sS https://starship.rs/install.sh | sh

# Add to shell config
echo 'eval "$(starship init bash)"' >> ~/.bashrc
```

**fish** - Friendly interactive shell
```bash
sudo apt install fish
# Or: brew install fish

# Set as default shell
chsh -s $(which fish)
```

**zsh + oh-my-zsh**
```bash
# Install zsh
sudo apt install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set as default
chsh -s $(which zsh)
```

---

## AI Agent Frameworks

### LangChain
**Most popular AI agent framework**

```bash
# Python
pip install langchain langchain-openai langchain-anthropic

# JavaScript
npm install langchain @langchain/openai @langchain/anthropic
```

**Features:**
- Chain composition
- Agent orchestration
- Memory management
- Tool integration

**Documentation:** https://python.langchain.com/

---

### CrewAI
**Multi-agent collaboration framework**

```bash
pip install crewai crewai-tools
```

**Features:**
- Role-based agents
- Task delegation
- Collaborative workflows
- Built-in tools

**Documentation:** https://docs.crewai.com/

---

### AutoGPT
**Autonomous AI agent**

```bash
git clone https://github.com/Significant-Gravitas/AutoGPT.git
cd AutoGPT
pip install -r requirements.txt
```

**Documentation:** https://docs.agpt.co/

---

### LiteLLM
**Unified LLM API interface**

```bash
pip install litellm

# Or as proxy server
docker run -p 4000:4000 ghcr.io/berriai/litellm:main-latest
```

**Features:**
- 100+ LLM support
- Unified API format
- Load balancing
- Cost tracking

**Documentation:** https://docs.litellm.ai/

---

### Agent Monitoring & Observability

#### AgentOps
```bash
pip install agentops
```

**Features:**
- Agent tracing
- Performance monitoring
- Error tracking
- Analytics

**Website:** https://agentops.ai/

---

#### LangSmith
```bash
pip install langsmith
```

**Features:**
- LangChain monitoring
- Trace debugging
- Dataset management
- Evaluation

**Website:** https://smith.langchain.com/

---

#### Helicone
```bash
# Proxy-based (no SDK needed)
# Just change your API endpoint
```

**Features:**
- LLM observability
- Cost tracking
- Caching
- Rate limiting

**Website:** https://helicone.ai/

---

## IDE Extensions

### VS Code

**Continue.dev** (Open Source Copilot Alternative)
```bash
# Install from VS Code Marketplace
code --install-extension continue.continue
```

**Cody** (Sourcegraph)
```bash
code --install-extension sourcegraph.cody-ai
```

**Cursor** (AI-Native Fork of VS Code)
- Download from https://cursor.sh/

---

### Neovim

**Codeium**
```vim
Plug 'Exafunction/codeium.vim'
```

**CopilotChat.nvim**
```vim
Plug 'CopilotC-Nvim/CopilotChat.nvim'
```

**Gp.nvim** (GPT Prompt)
```vim
Plug 'Robitx/gp.nvim'
```

---

### JetBrains

**JetBrains AI Assistant**
- Built-in (requires subscription)
- Settings → Plugins → AI Assistant

---

## Automated Installation

### Complete Setup Script

Save as `setup.sh`:

```bash
#!/bin/bash
set -e

echo "🚀 Starting OpenCode & AI Development Environment Setup..."

# Install package managers
echo "📦 Installing package managers..."
curl -fsSL https://bun.sh/install | bash
curl -LsSf https://astral.sh/uv/install.sh | sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Source cargo
source $HOME/.cargo/env

# Install OpenCode
echo "🤖 Installing OpenCode..."
npm install -g @opencode-ai/cli

# Install Oh My OpenCode
echo "⚡ Installing Oh My OpenCode..."
npm install -g oh-my-opencode

# Install modern CLI tools
echo "🛠️  Installing modern CLI tools..."
cargo install eza fd-find bat ripgrep zoxide procs git-delta starship

# Install Git tools
echo "📝 Installing Git tools..."
brew install lazygit gh || echo "Skipping brew installs (not on macOS)"

# Install Docker tools
echo "🐳 Installing Docker tools..."
brew install lazydocker dive || echo "Skipping brew installs"

# Install JSON/YAML tools
echo "📄 Installing JSON/YAML tools..."
sudo apt install -y jq || brew install jq
npm install -g fx

# Install Python AI frameworks
echo "🧠 Installing AI frameworks..."
uv pip install langchain langchain-openai langchain-anthropic crewai litellm agentops

# Setup shell aliases
echo "🎨 Setting up shell aliases..."
cat >> ~/.bashrc << 'EOF'

# Modern CLI aliases
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias tree='eza --tree --icons'
alias cat='bat'
alias find='fd'
alias grep='rg'
alias ps='procs'

# Git aliases
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias lg='lazygit'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias ld='lazydocker'

# Initialize tools
eval "$(zoxide init bash)"
eval "$(starship init bash)"
EOF

echo "✅ Installation complete!"
echo ""
echo "Next steps:"
echo "1. Restart your terminal or run: source ~/.bashrc"
echo "2. Configure API keys in ~/.config/opencode/.env"
echo "3. Run: opencode --help"
echo ""
echo "🎉 Happy coding!"
```

Make executable and run:
```bash
chmod +x setup.sh
./setup.sh
```

---

## Environment Variables

Create `~/.config/opencode/.env`:

```bash
# GitHub
export GITHUB_TOKEN="ghp_your_token"

# Search APIs
export TAVILY_API_KEY="tvly_your_key"
export EXA_API_KEY="your_exa_key"
export BRAVE_API_KEY="your_brave_key"
export CONTEXT7_API_KEY="your_context7_key"

# Databases
export POSTGRES_CONNECTION_STRING="postgresql://user:pass@host:5432/db"
export NEON_API_KEY="your_neon_key"

# Vector DBs
export QDRANT_URL="https://your-cluster.qdrant.io"
export QDRANT_API_KEY="your_qdrant_key"

# Cloud Services
export UPSTASH_REDIS_REST_URL="https://your-redis.upstash.io"
export UPSTASH_REDIS_REST_TOKEN="your_token"

# Productivity
export LINEAR_API_KEY="lin_api_your_key"
export NOTION_API_KEY="secret_your_token"
export N8N_API_KEY="your_n8n_key"
export N8N_BASE_URL="https://your-n8n.com"

# AI Services
export GEMINI_API_KEY="your_gemini_key"
export OPENROUTER_API_KEY="sk-or-your_key"
export AGENTOPS_API_KEY="your_agentops_key"

# Web Scraping
export FIRECRAWL_API_KEY="fc-your_key"

# Dev Tools
export DAYTONA_API_KEY="your_daytona_key"
export DAYTONA_SERVER_URL="https://your-daytona.com"
```

Load in shell:
```bash
echo 'source ~/.config/opencode/.env' >> ~/.bashrc
source ~/.bashrc
```

---

## Additional Resources

### Documentation
- [OpenCode Official Docs](https://opencode.ai/docs)
- [MCP Protocol Specification](https://modelcontextprotocol.io/)
- [Awesome OpenCode](https://awesomeopencode.com/)

### Community
- [OpenCode Reddit](https://reddit.com/r/opencodeCLI)
- [OpenCode Discord](https://discord.gg/opencode)
- [MCP Servers Registry](https://mcpservers.org/)

### Repositories
- [OpenCode GitHub](https://github.com/opencode-ai/opencode)
- [Oh My OpenCode](https://github.com/code-yeongyu/oh-my-openagent)
- [OpenAgents Control](https://github.com/darrenhinde/OpenAgentsControl)
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers)

---

**Generated:** 2026-03-13  
**Maintained by:** OpenCode Community  
**License:** MIT
