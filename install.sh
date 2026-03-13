#!/bin/bash
set -e

# OpenCode & AI Development Environment - Automated Setup Script
# Version: 1.0.0
# Last Updated: 2026-03-13

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
        if [ -f /etc/debian_version ]; then
            DISTRO="debian"
        elif [ -f /etc/redhat-release ]; then
            DISTRO="redhat"
        else
            DISTRO="unknown"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    else
        OS="unknown"
    fi
    
    log_info "Detected OS: $OS ($DISTRO)"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install package managers
install_package_managers() {
    log_info "Installing package managers..."
    
    # Install Bun
    if ! command_exists bun; then
        log_info "Installing Bun..."
        curl -fsSL https://bun.sh/install | bash
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
        log_success "Bun installed"
    else
        log_success "Bun already installed"
    fi
    
    # Install uv (Python package manager)
    if ! command_exists uv; then
        log_info "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
        export PATH="$HOME/.local/bin:$PATH"
        log_success "uv installed"
    else
        log_success "uv already installed"
    fi
    
    # Install Rust/Cargo
    if ! command_exists cargo; then
        log_info "Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        log_success "Rust installed"
    else
        log_success "Rust already installed"
    fi
    
    # Install Homebrew (macOS)
    if [[ "$OS" == "macos" ]] && ! command_exists brew; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        log_success "Homebrew installed"
    fi
}

# Install OpenCode
install_opencode() {
    log_info "Installing OpenCode..."
    
    if ! command_exists opencode; then
        if command_exists bun; then
            bun install -g @opencode-ai/cli
        else
            npm install -g @opencode-ai/cli
        fi
        log_success "OpenCode installed"
    else
        log_success "OpenCode already installed"
    fi
    
    # Verify installation
    opencode --version
}

# Install Oh My OpenCode
install_oh_my_opencode() {
    log_info "Installing Oh My OpenCode..."
    
    if command_exists bun; then
        bun install -g oh-my-opencode
    else
        npm install -g oh-my-opencode
    fi
    
    log_success "Oh My OpenCode installed"
}

# Install modern CLI tools
install_cli_tools() {
    log_info "Installing modern CLI tools..."
    
    # Rust-based tools
    local rust_tools=(
        "eza"           # Modern ls
        "fd-find"       # Modern find
        "bat"           # Modern cat
        "ripgrep"       # Modern grep
        "zoxide"        # Smart cd
        "procs"         # Modern ps
        "git-delta"     # Better git diff
        "starship"      # Cross-shell prompt
    )
    
    for tool in "${rust_tools[@]}"; do
        if ! command_exists "${tool%%-*}"; then
            log_info "Installing $tool..."
            cargo install "$tool" || log_warning "Failed to install $tool"
        fi
    done
    
    log_success "CLI tools installed"
}

# Install Git tools
install_git_tools() {
    log_info "Installing Git tools..."
    
    # GitHub CLI
    if ! command_exists gh; then
        if [[ "$OS" == "macos" ]]; then
            brew install gh
        elif [[ "$DISTRO" == "debian" ]]; then
            curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
            sudo apt update
            sudo apt install -y gh
        fi
        log_success "GitHub CLI installed"
    fi
    
    # lazygit
    if ! command_exists lazygit; then
        if [[ "$OS" == "macos" ]]; then
            brew install lazygit
        elif [[ "$DISTRO" == "debian" ]]; then
            LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
            curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
            tar xf lazygit.tar.gz lazygit
            sudo install lazygit /usr/local/bin
            rm lazygit lazygit.tar.gz
        fi
        log_success "lazygit installed"
    fi
}

# Install Docker tools
install_docker_tools() {
    log_info "Installing Docker tools..."
    
    # lazydocker
    if ! command_exists lazydocker; then
        if [[ "$OS" == "macos" ]]; then
            brew install lazydocker
        else
            curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
        fi
        log_success "lazydocker installed"
    fi
    
    # dive
    if ! command_exists dive; then
        if [[ "$OS" == "macos" ]]; then
            brew install dive
        elif [[ "$DISTRO" == "debian" ]]; then
            wget https://github.com/wagoodman/dive/releases/download/v0.12.0/dive_0.12.0_linux_amd64.deb
            sudo apt install -y ./dive_0.12.0_linux_amd64.deb
            rm dive_0.12.0_linux_amd64.deb
        fi
        log_success "dive installed"
    fi
}

# Install JSON/YAML tools
install_data_tools() {
    log_info "Installing JSON/YAML tools..."
    
    # jq
    if ! command_exists jq; then
        if [[ "$OS" == "macos" ]]; then
            brew install jq
        elif [[ "$DISTRO" == "debian" ]]; then
            sudo apt install -y jq
        fi
        log_success "jq installed"
    fi
    
    # yq
    if ! command_exists yq; then
        if [[ "$OS" == "macos" ]]; then
            brew install yq
        else
            wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O ~/.local/bin/yq
            chmod +x ~/.local/bin/yq
        fi
        log_success "yq installed"
    fi
    
    # fx
    if ! command_exists fx; then
        npm install -g fx
        log_success "fx installed"
    fi
}

# Install process monitoring tools
install_monitoring_tools() {
    log_info "Installing monitoring tools..."
    
    # btop
    if ! command_exists btop; then
        if [[ "$OS" == "macos" ]]; then
            brew install btop
        elif [[ "$DISTRO" == "debian" ]]; then
            sudo apt install -y btop
        fi
        log_success "btop installed"
    fi
}

# Install API testing tools
install_api_tools() {
    log_info "Installing API testing tools..."
    
    # httpie
    if ! command_exists http; then
        if [[ "$OS" == "macos" ]]; then
            brew install httpie
        elif [[ "$DISTRO" == "debian" ]]; then
            sudo apt install -y httpie
        fi
        log_success "httpie installed"
    fi
    
    # xh (Rust alternative)
    if ! command_exists xh; then
        cargo install xh
        log_success "xh installed"
    fi
}

# Install AI frameworks
install_ai_frameworks() {
    log_info "Installing AI frameworks..."
    
    if command_exists uv; then
        uv pip install langchain langchain-openai langchain-anthropic crewai litellm agentops langsmith
        log_success "AI frameworks installed"
    else
        log_warning "uv not found, skipping AI frameworks"
    fi
}

# Setup shell configuration
setup_shell_config() {
    log_info "Setting up shell configuration..."
    
    local shell_config="$HOME/.bashrc"
    
    # Detect shell
    if [[ "$SHELL" == *"zsh"* ]]; then
        shell_config="$HOME/.zshrc"
    fi
    
    # Backup existing config
    cp "$shell_config" "${shell_config}.backup-$(date +%Y%m%d-%H%M%S)"
    
    # Add aliases and configurations
    cat >> "$shell_config" << 'EOF'

# ============================================
# OpenCode & Modern CLI Tools Configuration
# Added by opencode-setup.sh
# ============================================

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
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias lg='lazygit'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'
alias ld='lazydocker'

# OpenCode aliases
alias oc='opencode'
alias ocm='opencode models'
alias occ='opencode config'

# Initialize tools
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init bash)"
fi

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Add local bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Add cargo bin to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Add bun to PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Load OpenCode environment variables
if [ -f "$HOME/.config/opencode/.env" ]; then
    source "$HOME/.config/opencode/.env"
fi

EOF
    
    log_success "Shell configuration updated"
}

# Create OpenCode config directory
setup_opencode_config() {
    log_info "Setting up OpenCode configuration..."
    
    mkdir -p ~/.config/opencode
    
    # Create .env template if it doesn't exist
    if [ ! -f ~/.config/opencode/.env ]; then
        cat > ~/.config/opencode/.env << 'EOF'
# OpenCode Environment Variables
# Copy this file and fill in your API keys

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
EOF
        log_success "Created .env template at ~/.config/opencode/.env"
    fi
}

# Main installation function
main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  OpenCode & AI Development Environment Setup              ║"
    echo "║  Version 1.0.0                                             ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    detect_os
    
    log_info "Starting installation..."
    echo ""
    
    # Installation steps
    install_package_managers
    echo ""
    
    install_opencode
    echo ""
    
    install_oh_my_opencode
    echo ""
    
    install_cli_tools
    echo ""
    
    install_git_tools
    echo ""
    
    install_docker_tools
    echo ""
    
    install_data_tools
    echo ""
    
    install_monitoring_tools
    echo ""
    
    install_api_tools
    echo ""
    
    install_ai_frameworks
    echo ""
    
    setup_shell_config
    echo ""
    
    setup_opencode_config
    echo ""
    
    # Final message
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  ✓ Installation Complete!                                  ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    log_success "All components installed successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Restart your terminal or run: source ~/.bashrc"
    echo "  2. Configure API keys in ~/.config/opencode/.env"
    echo "  3. Run: opencode --help"
    echo "  4. Run: opencode models (to see available models)"
    echo ""
    echo "Documentation:"
    echo "  - Installation Hub: ./INSTALLATION_HUB.md"
    echo "  - MCP Servers: ./MCP_SERVERS_DOCUMENTATION.md"
    echo "  - OpenCode Docs: https://opencode.ai/docs"
    echo ""
    echo "🎉 Happy coding!"
    echo ""
}

# Run main function
main "$@"
